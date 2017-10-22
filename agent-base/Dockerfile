FROM ubuntu:16.04

COPY ./rancher-entrypoint.sh /
ENV SSL_SCRIPT_COMMIT 98660ada3d800f653fc1f105771b5173f9d1a019
RUN apt-get update && \
        apt-get install --no-install-recommends -y \
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
        vim-tiny && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /bin/sh && ln -s /bin/bash /bin/sh

ENV SHARE_MNT_URL_amd64=https://github.com/zambon/rancher__runc/releases/download/share-mnt-v0.2.1-multi-arch/share-mnt-Linux-x86_64 \
    SHARE_MNT_URL_arm=https://github.com/zambon/rancher__runc/releases/download/share-mnt-v0.2.1-multi-arch/share-mnt-Linux-armv6l \
    SHARE_MNT_URL_ppc64le=https://github.com/zambon/rancher__runc/releases/download/share-mnt-v0.2.1-multi-arch/share-mnt-Linux-ppc64le \
    SHARE_MNT_URL=SHARE_MNT_URL_${ARCH}

ENV R_URL_amd64=https://github.com/zambon/rancher__weave/releases/download/r-v0.0.4-multi-arch/r-Linux-x86_64 \
    R_URL_arm=https://github.com/zambon/rancher__weave/releases/download/r-v0.0.4-multi-arch/r-Linux-armv6l \
    R_URL_ppc64le=https://github.com/zambon/rancher__weave/releases/download/r-v0.0.4-multi-arch/r-Linux-ppc64le \
    R_URL=R_URL_${ARCH}

ENV DOCKER_URL_amd64=https://cocl.us/docker-1.10.3-amd64.tgz \
    DOCKER_URL_arm=https://cocl.us/docker-1.10.3-arm.tgz \
    DOCKER_URL_ppc64le=https://cocl.us/docker-1.10.3-ppc64le.tgz \
    DOCKER_URL=DOCKER_URL_${ARCH}

RUN mkdir -p /var/lib/cattle /var/lib/rancher && \
    ln -s /usr/bin/python2.7 /usr/bin/python && \
    curl -s https://bootstrap.pypa.io/get-pip.py | python2.7 && \
    pip install cattle && \
    curl -fsSLo /usr/bin/share-mnt ${!SHARE_MNT_URL} && \
    chmod +x /usr/bin/share-mnt && \
    curl -fsSLo /usr/bin/r ${!R_URL} && \
    chmod +x /usr/bin/r && \
    curl -fsSL ${!DOCKER_URL} | tar -xzf - -C /usr/bin --strip-components=3 && \
    rm /var/run && \
    mkdir /var/run && \
    curl -fsSLo /usr/bin/update-rancher-ssl \
      https://raw.githubusercontent.com/rancher/rancher/${SSL_SCRIPT_COMMIT}/server/bin/update-rancher-ssl && \
    chmod +x /usr/bin/update-rancher-ssl

ENTRYPOINT ["/rancher-entrypoint.sh"]
