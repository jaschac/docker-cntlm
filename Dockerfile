FROM alpine:3.4
MAINTAINER Jascha Casadio <jascha@lostinmalloc.com>

RUN apk update \
 && apk upgrade \
 && apk add g++ \
            make \
            curl \
            bash \
            autoconf \
 && mkdir -p /usr/local/src/ \
 && cd /usr/local/src/ \
 && curl -L -O http://downloads.sourceforge.net/sourceforge/cntlm/cntlm-0.92.3.tar.gz \
 && tar zxvf cntlm-0.92.3.tar.gz \
 && cd cntlm-0.92.3 \
 && ./configure \
 && make \
 && make install \
 && rm /usr/local/src/cntlm-0.92.3.tar.gz \
 && apk del curl \
            g++ \
            autoconf \
            make \
 && rm -rf /var/lib/apt/lists/*

ADD scripts/init_container.sh /usr/local/sbin/init_container.sh
ADD files/etc/cntlm.conf /etc/cntlm.conf
EXPOSE 3128
CMD init_container.sh
