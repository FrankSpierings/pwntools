FROM ubuntu:latest
MAINTAINER Frank Spierings

# Base setup
RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y libstdc++6:i386 \
    && rm -rf /var/lib/apt/lists/*

# Locales setup
RUN apt-get update \
    && apt-get install -y \
        locales \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Convenience setup
RUN apt-get update \
    && apt-get install -y \
        bsdmainutils \
        ltrace \
        python \
        python-pip \
        qemu \
        strace \
        tmux \
        vim \
    && rm -rf /var/lib/apt/lists/* \
    && python -m pip install --upgrade pip \
    && python -m pip install --upgrade ipython

# GDB setup
RUN apt-get update \
    && apt-get install -y \
        gdbserver \
        gdb-multiarch \
    && rm -rf /var/lib/apt/lists/*

# Pwndbg
RUN apt-get update \
    && apt-get install -y \
        git \
        sudo \
    && rm -rf /var/lib/apt/lists/* \
    && python -m pip install --upgrade git+https://github.com/sashs/ropper.git \
    && DSTDIR=/opt \
    && cd ${DSTDIR} \
    && git clone https://github.com/pwndbg/pwndbg \
    && cd pwndbg && ./setup.sh

# Peda (default disabled)
RUN DSTDIR=/opt \
    && cd ${DSTDIR} \
    && git clone https://github.com/longld/peda.git ${DSTDIR}/peda \
    && echo "# source ${DSTDIR}/peda/peda.py" >> ~/.gdbinit

# Gef (default disabled)
RUN apt-get update \
    && apt-get install -y \
        cmake \
        wget \
    && rm -rf /var/lib/apt/lists/* \
    && python3 -m pip install --upgrade keystone-engine \
    && DSTDIR=/opt \
    && mkdir -p ${DSTDIR}/gef \
    && wget -O "${DSTDIR}/gef/gdbinit-gef.py" -q "https://github.com/hugsy/gef/raw/master/gef.py" \
    && echo "# source ${DSTDIR}/gef/gdbinit-gef.py" >> ~/.gdbinit

# Pwntools
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        git \
        libcapstone3 \
        libffi-dev \
        libssl-dev \
        python-dev \
        python-pip \
        python2.7 \
    && rm -rf /var/lib/apt/lists/* \
    && python -m pip install --upgrade pip \
    && python -m pip install --upgrade git+https://github.com/Gallopsled/pwntools.git@stable

# Angr for symbolic execution
RUN python3 -m pip install --upgrade angr


###
### Build this file: `docker build -t pwntools .`
### Run (iTerm2): `docker run -it -v /tmp/data:/tmp/data --privileged --name pwntools --hostname pwntools pwntools tmux -CC`
###
