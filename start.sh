#!/bin/sh
# start.sh

# Start Vault server
vault server -config=/vault/config/vault.hcl &

# Store the PID
VAULT_PID=$!

# Wait for vault to start
sleep 2

# Check if vault is running and listening on 0.0.0.0
echo "Checking Vault connectivity..."
netstat -tulpn | grep 8200

# Keep the container running
wait $VAULT_PID
