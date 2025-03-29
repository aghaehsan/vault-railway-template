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
# Using proper heredoc syntax to avoid newline issues
RUN cat > /vault/config/vault.hcl << 'EOF'
ui = true
storage "file" {
  path = "/vault/file"
}
listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = true
}
api_addr = "http://0.0.0.0:8200"
cluster_addr = "http://0.0.0.0:8201"
disable_mlock = true
EOF

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
