FROM httpd:latest

ADD http://apache.claz.org/perl/mod_perl-2.0.10.tar.gz mod_perl-2.0.10.tar.gz

RUN set -x \
    && apt-get update \
    && apt-get install -y libfile-spec-native-perl make gcc libperl-dev \
    && ln -s /usr/lib/x86_64-linux-gnu/libgdbm.so.3.0.0 /usr/lib/libgdbm.so \
    && tar -zxvf mod_perl-2.0.10.tar.gz \
    && rm mod_perl-2.0.10.tar.gz \
    && cd mod_perl-2.0.10 \
    && perl Makefile.PL MP_AP_PREFIX=/usr/local/apache2 \
    && make \ 
    && make install \
    && cd .. \
    && rm -r mod_perl-2.0.10  \
    && apt-get purge -y --auto-remove make gcc libperl-dev \
    && rm -rf /var/lib/apt/lists/*
    && echo  "Include /usr/local/apache2/conf/extra/perl.conf" >> /usr/local/apache2/conf/httpd.conf

ADD perl.conf  /usr/local/apache2/conf/extra/perl.conf
