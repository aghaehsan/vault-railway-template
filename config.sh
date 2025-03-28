echo "
{
  \"storage\": { \"file\": { \"path\": \"${STORAGE_PATH}\" } },
  \"listener\": [{ \"tcp\": { \"address\": \"[::]:8200\", \"tls_disable\": \"true\" } }],
  \"default_lease_ttl\": \"${DEFAULT_LEASE_TTL}\",
  \"max_lease_ttl\": \"${MAX_LEASE_TTL}\",
  \"ui\": true,
  \"disable_mlock\": true
}
" > config.json
