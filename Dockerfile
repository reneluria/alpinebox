FROM alpine
LABEL org.opencontainers.image.source https://github.com/reneluria/alpinebox

RUN apk add \
        bash \
        curl \
        gettext \
        openssl \
        ca-certificates

CMD ["/bin/bash"]
