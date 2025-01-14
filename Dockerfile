FROM ubuntu:20.04
LABEL maintainer="Parkeymon"
USER root
RUN echo "Building.."
RUN apt-get update
RUN apt install -y gnupg ca-certificates
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install preload
RUN apt install -y ffmpeg
RUN apt install -y curl
RUN apt install -y wget
RUN apt install -y lib32gcc1
RUN apt update
RUN curl -fsSL https://deb.nodesource.com/setup_15.x | bash -
RUN npm -v
RUN apt update
RUN dpkg --add-architecture i386
RUN apt update
RUN apt install -y mono-complete
RUN adduser --home /home/container container --disabled-password --gecos "" --uid 999
RUN usermod -a -G container container
RUN chown -R container:container /home/container
RUN mkdir /mnt/server
RUN chown -R container:container /mnt/server
ARG CACHBUST=1
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container
COPY ./entrypoint.sh /entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
