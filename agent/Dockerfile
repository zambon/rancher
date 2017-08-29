FROM rancher/agent-base:v0.3.0
ARG ARCH
COPY register.py resolve_url.py run.sh /
ENTRYPOINT ["/run.sh"]
LABEL "io.rancher.container.system"="rancher-agent"
RUN rm -f /bin/sh && ln -s /bin/bash /bin/sh
ENV SHARE_MNT_URL_amd64=https://github.com/rancher/share-mnt/releases/download/v1.0.0/share-mnt.tar.gz \
    SHARE_MNT_URL_ppc64le=https://github.com/zambon/rancher__share-mnt/releases/download/v1.0.0/share-mnt-Linux-ppc64le.tar.gz \
    SHARE_MNT_URL=SHARE_MNT_URL_${ARCH}
RUN curl -sL ${!SHARE_MNT_URL} | tar xvzf - -C /usr/bin
ENV RANCHER_AGENT_IMAGE rancher/agent:v1.2.5
