FROM httpd:latest

RUN set -x \
    && apt-get update \
    && apt-get install -y \
        curl  \
        libfile-spec-native-perl \
        libperl-dev \
        make \
        gcc \
    && ln -s /usr/lib/x86_64-linux-gnu/libgdbm.so.3.0.0 /usr/lib/libgdbm.so \
    && curl -SL http://apache.claz.org/perl/mod_perl-2.0.10.tar.gz \
        | tar -zxv \
    && cd mod_perl-2.0.10 \
    && perl Makefile.PL MP_AP_PREFIX=/usr/local/apache2 \
    && make \ 
    && make install \
    && cd .. \
    && rm -r mod_perl-2.0.10  \
    && cpan -i CPAN CGI\
    && rm -fr /root/.cpan/build /root/.cpan/sources \
    && apt-get purge -y --auto-remove make gcc libperl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN  set -x \
    && echo  "Include /usr/local/apache2/conf/extra/perl.conf" >> /usr/local/apache2/conf/httpd.conf \
    && sed 's/\(DirectoryIndex \)\(index.html\)/\1 index.pl index.html/' -i conf/httpd.conf  \
    && mkdir /cpan.d

ADD httpd-foreground  /usr/local/bin/httpd-foreground
ADD perl.conf  /usr/local/apache2/conf/extra/perl.conf
