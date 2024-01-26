FROM debian:bullseye-slim
ARG CONTROL_VERSION="4.10.0.0"
ENV DEBIAN_FRONTEND="noninteractive"

LABEL org.opencontainers.image.title="CODESYS Control SoftPLC"
LABEL org.opencontainers.image.authors="steffen@beyer.io"
LABEL org.opencontainers.image.source="https://github.com/serpent213/codesyscontrol-docker"
LABEL org.opencontainers.image.version="$CONTROL_VERSION"

# Update package list and install unzip
RUN apt-get update && \
    apt-get install -y supervisor unzip wget

WORKDIR /tmp
# Download from CodeSys server
RUN wget --output-document=cscontrol.zip --progress=dot:mega \
    "https://store-archive.codesys.com/ftp_download/3S/LinuxSL/2302000005/${CONTROL_VERSION}/CODESYS Control for Linux SL ${CONTROL_VERSION}.package"
# Extract the contents of the package
RUN unzip -p cscontrol.zip "*codemeter*.deb" > codemeter.deb && \
    unzip -p cscontrol.zip "*codesyscontrol*.deb" > codesyscontrol.deb

# Install dependencies from .deb files
RUN apt-get install -y ./codemeter.deb && \
    apt-get install -y ./codesyscontrol.deb

# Overwrite installed config files
COPY ./config/CODESYSControl.cfg /etc
COPY ./config/CODESYSControl_User.cfg /etc
COPY ./config/supervisord.conf /etc/supervisor/conf.d/codesys.conf

# Remove the extracted files and clean up
RUN apt-get remove -y unzip wget && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*.zip /tmp/*.deb

WORKDIR /var/opt/codesys
EXPOSE 1740-1743/udp 11740-11743/tcp 4840 8080 443
ENTRYPOINT ["/usr/bin/supervisord", "--configuration=/etc/supervisor/conf.d/codesys.conf"]
