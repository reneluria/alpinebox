FROM alpine

RUN apk add \
        bash \
        curl \
        gettext

CMD ["/bin/bash"]
