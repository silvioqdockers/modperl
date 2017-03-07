FROM debian:latest

RUN set -x \
    && apt-get update \
    && apt-get install -y \
      apache2  \
      libapache2-mod-perl2  \
    && rm -rf /var/lib/apt/lists/*


EXPOSE 80
