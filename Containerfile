FROM registry.access.redhat.com/ubi9:latest

USER 0

COPY ./chrome.repo /etc/yum.repos.d/chrome.repo
COPY ./entrypoint.sh /entrypoint.sh

RUN dnf install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm ; \
    dnf install -y tigervnc-server-minimal novnc google-chrome-stable alsa-firmware alsa-lib alsa-tools-firmware podman procps-ng openssl hostname xterm ; \
    chmod +x /entrypoint.sh

WORKDIR /tmp

ENTRYPOINT ["/usr/libexec/podman/catatonit","--","/entrypoint.sh"]
