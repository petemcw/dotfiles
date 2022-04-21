FROM amd64/ubuntu:20.04
LABEL maintainer="Pete McWilliams <petemcw@gmail.com>"

# Let the container know that there is no tty
ENV TRIGGER_REBUILD=2
ENV \
    DEBIAN_FRONTEND="noninteractive" \
    GIT_AUTHOR_EMAIL="petemcw@gmail.com" \
    GIT_AUTHOR_NAME="Pete McWilliams" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    TERM="xterm-256color" \
    TZ="America/Chicago"

# packages & configure
ENV TRIGGER_REBUILD_INSTALL=1
RUN \
    echo "**** install runtime packages ****" && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qqy \
        apt-transport-https \
        autoconf \
        build-essential \
        curl \
        git \
        lsb-release \
        python \
        python-setuptools \
        python-dev \
        sudo \
        tmux \
        vim \
        wget \
        zsh && \
    ln -nfs /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    echo "**** cleanup ****" && \
    apt-get clean && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

# user & files
ENV TRIGGER_REBUILD_COPY=5
RUN \
    echo "**** adding non-root user ****" && \
    useradd -rm -d /home/linuxbrew -s /bin/bash -g root -G sudo -u 1001 -p "$(openssl passwd -6 linuxbrew)" linuxbrew
USER linuxbrew
WORKDIR /home/linuxbrew
COPY . /home/linuxbrew/.dotfiles/

# Command to run
CMD [ "/bin/zsh" ]
