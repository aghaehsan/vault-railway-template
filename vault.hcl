ui = true

storage "file" {
  path = "/vault/file"
}

listener "tcp" {
  address = "[::]:8200"
  tls_disable = true
}

api_addr = "http://0.0.0.0:8200"
cluster_addr = "http://0.0.0.0:8201"

disable_mlock = true
