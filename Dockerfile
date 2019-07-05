ARG DUPLICATI_RELEASE="v2.0.4.5-2.0.4.5_beta_2018-11-28-ls24"
FROM linuxserver/duplicati:$DUPLICATI_RELEASE
ARG DUPLICATI_RELEASE
ARG DOCKER_RELEASE="18.09.7~3-0"

LABEL maintainer "Simon Guest <simon.guest@tesujimath.org>"

LABEL DUPLICATI_RELEASE="$DUPLICATI_RELEASE"
LABEL DOCKER_RELEASE="$DOCKER_RELEASE"

ENV HOME="/config"

RUN . /etc/os-release && curl https://download.docker.com/linux/ubuntu/dists/${UBUNTU_CODENAME}/pool/stable/amd64/docker-ce-cli_${DOCKER_RELEASE}~ubuntu-${UBUNTU_CODENAME}_amd64.deb --output docker-ce-cli.deb
RUN dpkg -i docker-ce-cli.deb
RUN rm -f docker-ce-cli.deb

EXPOSE 8200
VOLUME /backups /config /source
