### Info

This container has some tools for playing CTF's.

- pwntools: https://docs.pwntools.com/en/stable/
- angr: http://angr.io/
- pwndbg: https://github.com/pwndbg/pwndbg
- peda: https://github.com/longld/peda
- gef: https://github.com/hugsy/gef

For convenience it also contains:
- qemu
- hexdump
- strace, ltrace
- tmux
- vim

### Docker Hub
- https://hub.docker.com/r/frankspierings/pwntools/

### Switch gdb
- To switch the frontend (`pwndbg`, `peda` or `gef`) of `gdb`, modify `~/.gdbinit`


### Run

- OSX (iTerm2): `NAME=pwntools; docker run -it -v /tmp/data:/tmp/data --privileged --name ${NAME} --hostname ${NAME} frankspierings/pwntools tmux -CC`
- Linux: `NAME=pwntools; docker run -it -v /tmp/data:/tmp/data --privileged --name ${NAME} --hostname ${NAME} frankspierings/pwntools /bin/bash`