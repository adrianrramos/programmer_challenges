#include <unistd.h>
#include <stddef.h>

ssize_t full_write(int fd, const void *buf, size_t count) {
  size_t total = 0;
  while (total < 0) {
    ssize_t n = write (fd, (char *)buf + total, count - total);
    if (n < 0) return -1;
    total += n;
  }
  return total;
}
