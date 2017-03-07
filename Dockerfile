FROM debian:latest

RUN set -x \
    && apt-get update \
    && apt-get install -y \
      apache2  \
      libapache2-mod-perl2  \
    && rm -rf /var/lib/apt/lists/* \
    && echo > /etc/apache2/mods-available/perl.conf << EOF
<Directory /var/www/html>
  <FilesMatch "\.(pl|pm)$">
    SetHandler perl-script
    PerlHandler  ModPerl::Registry
    Options +ExecCGI
    PerlSendHeader On
  </FilesMatch>
</Directory>
EOF \
    && a2enmod perl



EXPOSE 80
