// TODO: improvments - implent the use of a TAIL node, and use in operations dealing with last_block
#include <stdatomic.h>
#include <stdint.h>
#include <assert.h>
#include <stdbool.h>
#include <stdint.h> // used for uint32_t
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>
// macOS deprecated use of sbrk
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

void debug_log(const char *msg) { write(STDOUT_FILENO, msg, strlen(msg));}

struct free_area {
  uint8_t marker;
  struct free_area *prev;
  bool in_use;
  uint32_t length;
  struct free_area *next;
};

struct stats {
  int magical_bytes;
  bool my_simple_lock;
  uint32_t amount_of_blocks;
  uint16_t amount_of_pages;
};

typedef struct stats my_stats;
typedef struct free_area area;

const int MAGICAL_BYTES = 0x55;
const int BLOCK_MARKER = 0xDD;
const int PAGE_SIZE = 4096;

char *heap_start = NULL;

my_stats *get_malloc_header() {
  assert(heap_start != NULL);
  my_stats *malloc_header = (my_stats *)heap_start;
  assert(malloc_header->magical_bytes == MAGICAL_BYTES);
  return malloc_header;
}

area *find_previous_used_block(area *ptr) {
  area *mov_ptr = ptr;
  while (mov_ptr->prev != NULL) {
    mov_ptr = mov_ptr->prev;
    if (mov_ptr->in_use == true) {
      return mov_ptr;
    }
  }
  return NULL;
}


// TODO: update this function to NOT start all over but instead,
// find the last starting from a given block
area *find_last_block() {
  my_stats *malloc_header = get_malloc_header();
  area *block = (area *)((char *)malloc_header + sizeof(my_stats));
  while (block->next != NULL) {
    block = block->next;
  }
  return block;
}

void reduce_heap_size_if_possible() {
  area *last_block = find_last_block();
  area *prev_used_block = find_previous_used_block(last_block);
  if (prev_used_block == NULL) {
    // It is the only block, which should never be deleted. We could only reduce its size to 1 Page
    if (last_block->length > PAGE_SIZE) {
      last_block->length = PAGE_SIZE;
    }
    prev_used_block = last_block;
  }
  
  void *new_end = (void *)prev_used_block + sizeof(area) + prev_used_block->length;
  void *heap_end = sbrk(0);
  my_stats *malloc_header = get_malloc_header();
  while (new_end < heap_end - PAGE_SIZE) {
    sbrk(-PAGE_SIZE);
    heap_end = sbrk(0);
    malloc_header->amount_of_pages -= 1;
  }

  // Now in most cases there is remaining space between the new end
  // and the heap end. If there is enough space to inject a block we will.
  if (heap_end - new_end > sizeof(area) + 1) {
    area *new_not_used_block = (area *)new_end;
    *new_not_used_block = (area){
      .marker = BLOCK_MARKER,
      .in_use = false,
      .prev = prev_used_block,
      .next = NULL,
      .length = (size_t)((char *)heap_end - (char *)new_end) - sizeof(area),
    };
    prev_used_block->next = new_not_used_block;
  }
}

bool an_free(void *ptr) {
  my_stats *malloc_header = get_malloc_header();
  while (malloc_header->my_simple_lock) {
    sleep(1);
  };
  malloc_header->my_simple_lock = true;
  // free does not get the start of the block but the start of the data area of the block.
  area *block = ptr - sizeof(area);
  if (block->marker != BLOCK_MARKER) {
    // the given pointer is not the start of any malloc block
    return false;
  } else {
    block->in_use = false;
    // fill the entire freed user buffer with zero bytes
    memset(ptr, 0, block->length);
    if (block->next != NULL && (block->next)->in_use == false) {
      // Next block is not used, we can merge them
      area *not_used_next_block = block->next;
      // skip next block in linked list to connect current block and two blocks ahead
      block->next = not_used_next_block->next;
      // if two blocks ahead, the block is not null, we connect it back.
      if (not_used_next_block->next != NULL) {
        not_used_next_block->next->prev = block;
      }

      // current block adds the next block
      block->length += sizeof(area) + not_used_next_block->length;
      // erase header and data; take into account the header of the malloc structure
      memset((void *)not_used_next_block, 0, sizeof(area) + not_used_next_block->length);
      malloc_header->amount_of_blocks -= 1;
    }

    if (block->prev != NULL && (block->prev)->in_use == false) {
      // previous block can be merged with current, so we delete current.
      area *to_delete_block = block;
      block = block->prev;
      // previous block gets new extra size
      block->length += sizeof(area) + to_delete_block->length;
      // skip next block. to_delete_block cannot be null, since we check that above
      block->next = to_delete_block->next;
      // backward connection
      if (block->next != NULL) {
        block->next->prev = block;
      }
      malloc_header->amount_of_blocks -= 1;
    }
    reduce_heap_size_if_possible();
  }
  malloc_header->my_simple_lock = false;
  return true;
}

int *add_used_block(ssize_t size) {
  my_stats *malloc_header = get_malloc_header();
  while (malloc_header->my_simple_lock) {
    sleep(1);
  }
  malloc_header->my_simple_lock = true;
  area *block = (area *)((char *)heap_start + sizeof(my_stats));
  area *smallest_block = NULL;
  area *last_block = block;

  // look for smallest block that contains a length of desired size OR greater
  while (block != NULL) {
    assert(block->marker == BLOCK_MARKER);
    if ((block->length + sizeof(area)) >= size && block->in_use == false) {
      if (smallest_block == NULL || smallest_block->length > block->length) {
        smallest_block = block;
      }
    }
    last_block = block;
    block = block->next;
  }

  // no big enough blocks.
  if (smallest_block == NULL) {
    area *last_block = find_last_block();
    // endlessly adding a page worth of bytes to the last_block to meet the size
    // requirement is only possible because last_block->length and sbrk(0)
    // both point to the end of the heap
    while (last_block->length < size) {
      sbrk(PAGE_SIZE);
      last_block->length += PAGE_SIZE;
      malloc_header->amount_of_pages += 1;
    }
    smallest_block = last_block;
  }
  // found a block
  smallest_block->in_use = true;

  // create a new block, which will be free. The list always must end on a free
  // block. The size of area header is part of the check because it will need 
  // space too for the new block. Also, at least one byte is needed for the new 
  // block's content
  int must_have_size = smallest_block->length - size - sizeof(area) - 1;
  if (must_have_size <= 0) {
    sbrk(PAGE_SIZE);
    malloc_header->amount_of_pages += 1;
    last_block->length += PAGE_SIZE;
    // this is needed if smallest_block == last_block
    must_have_size = smallest_block->length - size - sizeof(area) - 1;
  }

  // complete the split, this new_block is made by using the remaining memory 
  // that did not get taken from small_block or last_block
  int remaining_size = must_have_size += 1;
  malloc_header->amount_of_blocks += 1;
  area *new_block = (area *)((char *)smallest_block + sizeof(area) + size);
  new_block->marker = BLOCK_MARKER;
  new_block->in_use = false;
  new_block->prev = smallest_block;
  new_block->next = smallest_block->next;
  new_block->length = remaining_size;
  if (new_block->next != NULL) {
    (new_block->next)->prev = new_block;
  }

  smallest_block->next = new_block;
  smallest_block->length = size;
  malloc_header->my_simple_lock = false;
  return (int *)((char *)smallest_block + sizeof(area));
}

int *an_malloc(ssize_t size) {
  if (heap_start == NULL) {
    // sbrk increments the program's data space by N bytes; sbrk then returns 
    // the current heap end.
    // calling sbrk with an increment of 0 can be used to find the current 
    // location of the program break
    heap_start = sbrk(0);
    sbrk(PAGE_SIZE);
  }
  char *heap_end = sbrk(0);
  long int length = heap_end - heap_start;

  if ((*heap_start) != MAGICAL_BYTES) {
    // first execution of malloc, preparing the header and first block
    *(heap_start) = MAGICAL_BYTES;
    my_stats *malloc_header = (my_stats *)heap_start;
    malloc_header->amount_of_blocks = 1;
    malloc_header->amount_of_pages = 1;
    area *first_block = (area *)((char *)heap_start + sizeof(my_stats));

    first_block->marker = BLOCK_MARKER;
    first_block->in_use = false;
    first_block->length = length - sizeof(my_stats) - sizeof(area);
    first_block->next = NULL;
    first_block->prev = NULL;
  }
  return add_used_block(size);
}


int main(void)
{
  return 0;
}
