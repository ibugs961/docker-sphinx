FROM alpine:3.8

RUN apk --update add py-pip && \
    apk --update add -t deps git gcc libjpeg-turbo-dev musl-dev python-dev zlib-dev && \
    pip install -U sphinx==1.7.6 Pygments setuptools \
                   docutils mkdocs mock pillow \
                   git+https://github.com/rtfd/readthedocs-sphinx-ext.git \
                   sphinx-rtd-theme alabaster \
                   commonmark git+https://github.com/rtfd/recommonmark.git \
                   git+https://github.com/mgaitan/sphinxcontrib-mermaid.git && \
    apk del --purge deps && \
    rm -rf /root/.cache /var/cache/apk/*

EXPOSE 8888

WORKDIR $HOME

CMD /bin/sh
