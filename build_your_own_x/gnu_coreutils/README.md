# My version of GNU Coreutils

Rewriting some of the most well-known GNU Coreutils as a learning exercise.
These are bare-bones implementations — not drop-in replacements — and are
neither fully featured nor production ready.

### Guidelines for Writing a New Util

- [ ] **Satisfy basic usage.** Core behavior must work (e.g. `cat file.txt`),
      but flags and edge cases are out of scope.
- [ ] **No AI or third-party headers.** Only the C99 standard library is
      allowed. When something isn't supported natively, follow this order:
  - [ ] Does C99 support this?
  - [ ] If not, can and should I roll my own?
  - [ ] If not, is there a syscall available?
  - [ ] ...and so on.
- [ ] **Follow the UNIX philosophy.** Keep programs small and composable —
      stdin/stdout must support piping (e.g. `cat file.txt | less`).
- [ ] **Stay compatible with GNU Coreutils** for basic functionality,
      allowing interchangeability where it matters.

### References
- [GNU Coreutils Source](https://cgit.git.savannah.gnu.org/cgit/coreutils.git/tree/)
- [GNU Coreutils Manual](https://www.gnu.org/software/coreutils/)
- [Linux Man Pages](https://man7.org/linux/man-pages/index.html)
