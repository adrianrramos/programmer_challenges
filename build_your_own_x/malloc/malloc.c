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

char *heap_start = NULL;

my_stats *get_malloc_header() {
  assert(heap_start != NULL);
  my_stats *malloc_header = (my_stats *)heap_start;
  assert(malloc_header->magical_bytes == MAGICAL_BYTES);
  return malloc_header;
}

area *find_last_block() {
  my_stats *malloc_header = get_malloc_header();
  area *block = (area *)((char *)malloc_header + sizeof(my_stats));
  while (block->next != NULL) {
    block = block->next;
  }
  return block;
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
    while (last_block->length < size) {
      sbrk(4096);
      last_block->length += 4096;
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
    sbrk(4096);
    malloc_header->amount_of_pages += 1;
    last_block->length += 4096;
    must_have_size = smallest_block->length - size - sizeof(area) - 1;
  }

  int remaining_size = must_have_size += 1;
  malloc_header->amount_of_blocks += 1;
  area *new_block = (area *)((char *)smallest_block + sizeof(area) + size);
  new_block->marker = BLOCK_MARKER;
  new_block->prev = smallest_block;
  new_block->next = smallest_block->next;
  if (new_block->next != NULL) {
    (new_block->next)->prev = new_block;
  }

  smallest_block->next = new_block;
  new_block->length = remaining_size;
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
    sbrk(4096);
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
