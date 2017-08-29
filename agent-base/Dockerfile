FROM zambon/ubuntu-multi:16.04

ARG ARCH

RUN apt-get -q update && apt-get -qy install --no-install-recommends \
      arptables \
      bridge-utils \
      ca-certificates \
      conntrack \
      curl \
      ethtool \
      iproute2 \
      iptables \
      iputils-ping \
      jq \
      kmod \
      openssl \
      psmisc \
      python2.7 \
      tcpdump \
      vim-tiny \
    && rm -rf /var/lib/apt/lists/* && \
    rm -f /bin/sh && ln -s /bin/bash /bin/sh

ENV SHARE_MNT_URL_amd64=https://github.com/rancher/runc/releases/download/share-mnt-v0.2.1/share-mnt \
    SHARE_MNT_URL_ppc64le=https://github.com/zambon/rancher__runc/releases/download/share-mnt-v0.2.1-ppc64le/share-mnt-Linux-ppc64le \
    SHARE_MNT_URL=SHARE_MNT_URL_${ARCH}

ENV R_URL_amd64=https://github.com/rancher/weave/releases/download/r-v0.0.4/r \
    R_URL_ppc64le=https://github.com/zambon/rancher__weave/releases/download/r-v0.0.4-ppc64le/r-Linux-ppc64le \
    R_URL=R_URL_${ARCH}

ENV DOCKER_URL_amd64=https://get.docker.com/builds/Linux/x86_64/docker-1.10.3 \
    DOCKER_URL_ppc64le=https://github.com/zambon/moby/releases/download/v1.10.3/docker-1.10.3_ppc64le \
    DOCKER_URL=DOCKER_URL_${ARCH}

ENV SSL_SCRIPT_COMMIT=98660ada3d800f653fc1f105771b5173f9d1a019

RUN mkdir -p /var/lib/cattle /var/lib/rancher && \
    ln -s /usr/bin/python2.7 /usr/bin/python && \
    curl -s https://bootstrap.pypa.io/get-pip.py | python2.7 && \
    pip install cattle && \
    curl -fsSLo /usr/bin/share-mnt ${!SHARE_MNT_URL} && \
    chmod +x /usr/bin/share-mnt && \
    curl -fsSLo /usr/bin/r ${!R_URL} && \
    chmod +x /usr/bin/r && \
    curl -fsSLo /usr/bin/docker ${!DOCKER_URL} && \
    chmod +x /usr/bin/docker && \
    rm /var/run && \
    mkdir /var/run && \
    curl -fsSLo /usr/bin/update-rancher-ssl https://raw.githubusercontent.com/rancher/rancher/${SSL_SCRIPT_COMMIT}/server/bin/update-rancher-ssl && \
    chmod +x /usr/bin/update-rancher-ssl

COPY ./rancher-entrypoint.sh /

ENTRYPOINT ["/rancher-entrypoint.sh"]
