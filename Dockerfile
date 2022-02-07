ARG UPSTREAM_VERSION=latest
FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y ca-certificates
COPY --from=lthn/chain:latest --chmod=+x /usr/local/bin/lethean* /usr/local/bin/

ENV LOG_LEVEL 3

# P2P live + testnet
ENV P2P_BIND_IP 0.0.0.0
ENV P2P_BIND_PORT 48772
ENV TEST_P2P_BIND_PORT 38772

# RPC live + testnet
ENV RPC_BIND_IP=0.0.0.0
ENV RPC_BIND_PORT=48782
ENV TEST_RPC_BIND_PORT=38782
ENV DATA_DIR /root/Lethean/data
ENV TEST_DATA_DIR /root/Lethean/data/testnet

ENTRYPOINT ["sh", "-c", "letheand", "--help --confirm-external-bind --data-dir=${DATA_DIR} --testnet-data-dir=${TEST_DATA_DIR} --log-level=${LOG_LEVEL} --testnet-rpc-bind-port=${TEST_RPC_BIND_PORT} --testnet-p2p-bind-port=${TEST_P2P_BIND_PORT} --p2p-bind-ip=${P2P_BIND_IP}  --rpc-bind-ip=${RPC_BIND_IP} --p2p-bind-port=${P2P_BIND_PORT}  --rpc-bind-port=${RPC_BIND_PORT} ${EXTRA_FLAGS}"]

