FROM alpine:3
LABEL org.opencontainers.image.source https://github.com/reneluria/alpinebox

RUN apk add \
        bash \
        curl \
        gettext \
        jq \
        openssh-client \
        openssl \
        git \
        rsync \
        ca-certificates

ENV kubectl_version="v1.30.3"

RUN \
        curl -LO "https://dl.k8s.io/release/$kubectl_version/bin/linux/amd64/kubectl" && \
        curl -LO "https://dl.k8s.io/release/$kubectl_version/bin/linux/amd64/kubectl.sha256" && \
        echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c && \
        install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
        rm kubectl kubectl.sha256

ENV kustomize_version="v5.5.0"
RUN \
        curl -LO "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F$kustomize_version/kustomize_${kustomize_version}_linux_amd64.tar.gz" && \
        curl -LO "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F$kustomize_version/checksums.txt" && \
        grep "kustomize_${kustomize_version}_linux_amd64.tar.gz" checksums.txt | sha256sum -c && \
        tar xzf "kustomize_${kustomize_version}_linux_amd64.tar.gz" && \
        install -o root -g root -m 0755 kustomize /usr/local/bin/kustomize && \
        rm "kustomize_${kustomize_version}_linux_amd64.tar.gz" kustomize checksums.txt

ENV FLUX_VERSION="2.4.0"
RUN curl -s https://fluxcd.io/install.sh | bash

CMD ["/bin/bash"]
