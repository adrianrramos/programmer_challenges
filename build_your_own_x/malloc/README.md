# MALLOC IS NOT MAGIC

An implementation of malloc following this [tutorial](https://levelup.gitconnected.com/malloc-is-not-magic-implementing-my-own-memory-allocator-e0354e914402)

## Goals
- [ ] Keep a list of memory locations inside the heap where the memory is free
- [ ] Keep track of all allocations made
- [ ] On demand, return a new free memory area of a given size. If the size
    is bigger than all existing free blocks, this implementation will request the OS
    to grow the heap.
- [ ] On demand, free a chosen block. Freeing blocks can result in a request to the OS
    to reduce the size of the heap.
- [ ] It is thread-safe (it can be used from multiple threads at the same time)
