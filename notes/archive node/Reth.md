https://paradigmxyz.github.io/reth/installation/installation.html

Noch in Beta (1.0 soll "vor Ende Q2" kommen). Von denselben developern wie Foundry, auch in Rust geschrieben.

Sync Time: 2 Tage auf sehr guter Hardware. 6h mit sehr guter Hardware, wenn man von einem public snapshot der databases anfängt.

## Requirements:

Disk: At least 2.2TB (TLC NVMe recommended)
Memory: 8GB+
CPU: High clock speed over core count
Bandwidth: Stable 24Mbps+

#### Network

https://paradigmxyz.github.io/reth/run/ports.html

Reth:
- 30303: Peering (exposed publicly)
- 9001: Metrics (internal, customizable)
- 8545: RPC http (internal?, customizable)
- (8546: RPC ws (internal?, customizable))
- 8551: Engine API (internal, customizable)

Lighthouse (https://lighthouse-book.sigmaprime.io/docker.html#ports, https://lighthouse-book.sigmaprime.io/advanced_networking.html):
- 5052: RPC?
- 5053: ?
- 5054: Metrics?
- 9000: P2P (exposed publicly)
- 9091: Metrics (internal, customizable)

Reth observability:
- 9090: Prometheus (internal, customizable)
- 3000: Grafana (internal, customizable)
