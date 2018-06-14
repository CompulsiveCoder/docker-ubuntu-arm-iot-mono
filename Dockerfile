FROM compulsivecoder/ubuntu-arm-iot

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get install -y apt-transport-https dirmngr software-properties-common \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/ubuntu stable-trusty main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-get update && apt-get -y upgrade && apt-get install -y mono-complete mono-devel ca-certificates-mono msbuild systemd libltdl7 \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
RUN add-apt-repository -y ppa:eugenesan/ppa \
    && apt-get -y update \
    && apt-get -y upgrade \
    && apt-get -y install jq\
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
CMD ["/usr/sbin/init"]

