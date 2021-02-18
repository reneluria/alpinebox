FROM alpine

RUN apk add \
        bash \
        curl \
        gettext \
        openssl \
        ca-certificates

CMD ["/bin/bash"]
