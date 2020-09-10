FROM nforceroh/d_alpine-s6:edge

LABEL maintainer="sylvain@nforcer.com"

ENV PYTHONIOENCODING=UTF-8
ENV LC_ALL=en_US.UTF-8  
ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US.UTF-8  

RUN \
  apk add --no-cache nodejs git mediainfo unrar tzdata libffi openssl \
  && apk add --no-cache --virtual .build-deps gcc libffi-dev openssl-dev musl-dev python3-dev \
  && /usr/bin/pip3 install pyopenssl \
  && apk del .build-deps \
  && git clone --depth 1 https://github.com/SickChill/SickChill.git /app

COPY rootfs/ /
WORKDIR /app
VOLUME /config
EXPOSE 8081
ENTRYPOINT [ "/init" ]
#CMD /bin/bash
