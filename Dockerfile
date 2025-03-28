FROM hashicorp/vault:1.14

ARG STORAGE_PATH
ARG DEFAULT_LEASE_TTL
ARG MAX_LEASE_TTL
ARG UI_ENABLED
ARG ENV=dev

COPY config.sh /config.sh

RUN apk update && \
    apk add --no-cache tcpdump
RUN chmod +x /config.sh && \
    export STORAGE_PATH=${STORAGE_PATH} && \
    export DEFAULT_LEASE_TTL=${DEFAULT_LEASE_TTL} && \
    export MAX_LEASE_TTL=${MAX_LEASE_TTL} && \
    export UI_ENABLED=${UI_ENABLED} && \
    /config.sh

RUN mv ./config.json /vault/config/config.json

CMD if [ "$ENV" = "dev" ]; then vault server --dev; else vault server -config=/vault/config/config.json; fi
