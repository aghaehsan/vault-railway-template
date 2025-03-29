FROM hashicorp/vault:1.14

USER root

# Install troubleshooting tools
RUN apk update && \
    apk add --no-cache \
    tcpdump \
    busybox-extras \
    curl \
    jq \
    bind-tools \
    iputils

# Create directory and copy config
RUN mkdir -p /vault/config
COPY vault.hcl /vault/config/vault.hcl

# Set permissions
RUN chown -R vault:vault /vault

USER vault

EXPOSE 8200 8201

CMD ["vault", "server", "-dev", "-dev-listen-address=0.0.0.0:8200"]
