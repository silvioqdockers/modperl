FROM debian:latest

RUN set -x \
    && apt-get update \
    && apt-get install -y \
      apache2  \
      libapache2-mod-perl2  \
    && rm -rf /var/lib/apt/lists/*

ADD  perl.conf /etc/apache2/mods-available/perl.conf
RUN  a2enmod perl


EXPOSE 80
