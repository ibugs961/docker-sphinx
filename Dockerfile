FROM alpine:3.8

ENV SPHINX_VERSION=1.7.6
ENV SPHINX_RTD_THEME_VERSION=0.4.2
ENV JIE_BA_VERSION=0.39
ENV HOME=/

RUN apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi

RUN apk --update add py-pip && \
    apk --update add -t deps git gcc libjpeg-turbo-dev musl-dev python-dev zlib-dev && \
    pip install -U sphinx==$SPHINX_VERSION Pygments setuptools \
                   docutils mkdocs mock pillow \
                   git+https://github.com/rtfd/readthedocs-sphinx-ext.git \
                   sphinx-rtd-theme==$SPHINX_RTD_THEME_VERSION alabaster \
                   jieba==$JIE_BA_VERSION \
                   commonmark git+https://github.com/rtfd/recommonmark.git \
                   git+https://github.com/mgaitan/sphinxcontrib-mermaid.git && \
    apk del --purge deps && \
    rm -rf /root/.cache /var/cache/apk/*

EXPOSE 8888

WORKDIR $HOME

CMD /bin/sh
