FROM debian:bullseye-slim

LABEL maintainer="hack3d <hack3d.dev@googlemail.com>"

ARG UID=1000
ARG GID=1000

RUN apt-get update -qq \
    && apt-get install -qq -y --no-install-recommends \
        tftpd-hpa=5.2+20150808-1.2  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && groupadd -g $GID customgroup \
    && useradd -r -u $UID -g customgroup customuser

CMD ["in.tftpd", "--user", "customuser", "--ipv4", "--foreground", "--listen", "--address", "0.0.0.0:69", "--create", "--secure", "-vvv", "/data"]