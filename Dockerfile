ARG DUPLICATI_RELEASE
FROM linuxserver/duplicati:$DUPLICATI_RELEASE
ARG DUPLICATI_RELEASE
ARG DOCKER_RELEASE

LABEL maintainer "Simon Guest <simon.guest@tesujimath.org>"

LABEL DUPLICATI_RELEASE="$DUPLICATI_RELEASE"
LABEL DOCKER_RELEASE="$DOCKER_RELEASE"

ENV HOME="/config"

RUN . /etc/os-release && curl https://download.docker.com/linux/ubuntu/dists/${UBUNTU_CODENAME}/pool/stable/amd64/docker-ce-cli_${DOCKER_RELEASE}~ubuntu-${UBUNTU_CODENAME}_amd64.deb --output docker-ce-cli.deb
RUN dpkg -i docker-ce-cli.deb
RUN rm -f docker-ce-cli.deb

EXPOSE 8200
VOLUME /backups /config /source
