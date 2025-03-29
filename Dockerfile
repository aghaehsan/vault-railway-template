FROM hashicorp/vault:1.14

# Switch to root to install packages
USER root

# Install useful troubleshooting tools
RUN apk update && \
    apk add --no-cache \
    tcpdump \
    busybox-extras \
    curl \
    jq \
    bind-tools \
    iputils

# Create vault configuration
RUN mkdir -p /vault/config

# Create a vault.hcl file that listens on all interfaces
RUN echo 'ui = true \n\
storage "file" { \n\
  path = "/vault/file" \n\
} \n\
listener "tcp" { \n\
  address = "0.0.0.0:8200" \n\
  tls_disable = true \n\
} \n\
api_addr = "http://0.0.0.0:8200" \n\
cluster_addr = "http://0.0.0.0:8201" \n\
disable_mlock = true' > /vault/config/vault.hcl

# Add startup script with health check
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Make sure the vault user owns its directories
RUN chown -R vault:vault /vault

# Switch back to vault user
USER vault

# Expose the API and cluster ports
EXPOSE 8200 8201

# Start Vault
CMD ["/usr/local/bin/start.sh"]
