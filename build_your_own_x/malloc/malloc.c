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

}

int *an_malloc(ssize_t size) {
  if (heap_start == NULL) {
    heap_start = sbrk(0);
    sbrk(4096);
  }
  char *heap_end = sbrk(0);
  long int length = heap_end - heap_start;

  if ((*heap_start) != MAGICAL_BYTES) {
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

