FROM compulsivecoder/ubuntu-arm-iot

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get install -y apt-transport-https dirmngr \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
    && echo "deb https://download.mono-project.com/repo/ubuntu stable-trusty main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list \
    && apt-get update && apt-get -y upgrade && apt-get install -y mono-complete mono-devel ca-certificates-mono msbuild jq libltdl7 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y systemd \
    && rm -rf /var/lib/apt/lists/*

# systemd

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/# deb/deb/g' /etc/apt/sources.list

RUN apt-get update \
    && apt-get install -y systemd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /lib/systemd/system/sysinit.target.wants/ \
    && ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1

RUN rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/anaconda.target.wants/* \
    /lib/systemd/system/plymouth* \
    /lib/systemd/system/systemd-update-utmp*

RUN apt-get update \
    && apt-get install -y systemd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]

