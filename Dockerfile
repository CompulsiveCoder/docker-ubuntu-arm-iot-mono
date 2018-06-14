FROM arm32v7/ubuntu:xenial

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install \
        apt-utils \
      	apt-transport-https \
      	build-essential \
        curl \
        git \
        rsync \
        sudo \
        wget \
        python \
        zip \
        unzip \
        && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get -y install python && rm -rf /var/lib/apt/lists/*

# Platformio
RUN python -c "$(curl -fsSL https://raw.githubusercontent.com/platformio/platformio/develop/scripts/get-platformio.py)"

# Mono
RUN apt-get update && apt-get install -y apt-transport-https dirmngr software-properties-common \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/ubuntu stable-$(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-get update && apt-get -y upgrade && apt-get install -y mono-complete mono-devel ca-certificates-mono msbuild systemd libltdl7 \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN add-apt-repository -y ppa:eugenesan/ppa \
    && apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install jq\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
CMD ["/usr/sbin/init"]

