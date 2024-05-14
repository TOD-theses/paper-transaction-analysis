https://paradigmxyz.github.io/reth/installation/installation.html

Etablierte archive node, aus Geth weiterentwickelt.

Sync Time: 2 Tage auf sehr guter Hardware. 6h mit sehr guter Hardware, wenn man von einem public snapshot der databases anfängt.

## Requirements:

Disk: At least 3.5TB
Memory: 16GB+

#### Network

https://github.com/ledgerwatch/erigon?tab=readme-ov-file#default-ports-and-firewalls
https://github.com/ledgerwatch/erigon/blob/main/docker-compose.yml

Erigon engine + sentry + rpcdaemon:
- 30303: Peering (exposed publicly)
- (30304: Peering (exposed publicly))
- 8545: RPC (internal?)
- 8551: Engine API (internal, customizable)
- 42069: Snap sync via Bittorrent (public)
- 9090: gRPC Server (internal, but somehow not mentioned in docker-compose)
- 9091: incoming gRPC connections (internal)

Caplin (or instead use Lighthouse):
- 4000: Peering (public)
- 4001: Peering (public)

Erigon observability:
- 6060: pprof & metrics (internal, customizable)
- 9090: Prometheus (internal, customizable)
- 3000: Grafana (internal, customizable)

...