
https://paradigmxyz.github.io/reth/installation/installation.html
https://paradigmxyz.github.io/reth/run/mainnet.html

## Run instructions

1. First time only: create a JWT secret with `./reth_repository/etc/generate-jwt.sh`
2. First time only: Create the data directories with `./make_volume_dirs.sh`
3. Set shell alias for convenience: `. set_alias.sh` (see `cat set_alias.sh`)
4. Run in background with `reth_compose up -d`

Common commands:
- view the logs with `reth_compose logs -f`
- view the running containers with `reth_compose ps`
- view the dashboards at http://localhost:3000
## git

For the repository `./reth_repository`  we use the `customized` branch. We only use the configs in `./reth_repository/etc`, the source code is not used by our setup.

For updating, go to the main branch and pull. Then switch to `customized` and make a rebase, such that our commits will stay on the top of the history.
## docker compose

We use docker compose to manage the different services. There is one for reth ([execution client](https://ethereum.org/en/developers/docs/nodes-and-clients/#execution-clients)) and one for lighthouse ([consensus client](https://ethereum.org/en/developers/docs/nodes-and-clients/#consensus-clients)).

Because the volumes would be stored in `/var/lib/docker/volumes/...`, we modified the docker-compose files to store them in `/data-nvme/reth` instead. (Use a git diff to see the changed values).

Also note, that reth repository contains some config files that are passed to the containers via volumes. So at least the configs from the repository must exist next to the docker-compose files.
### docker-compose.yml
Contains 3 services:
#### Reth
The execution client
Ports:
- 9001: metrics (internal, for Prometheus)
- 30303: P2P (public, [devp2p](https://github.com/ethereum/devp2p))
- 8545: RPC (internal)
- 8551: Engine API (internal, for Lighthouse)
Volumes:
- mainnet_data:/root/.local/share/reth/mainnet
- sepolia_data:/root/.local/share/reth/sepolia
- holesky_data:/root/.local/share/reth/holesky
- logs:/root/logs
- ./jwttoken:/root/jwt:ro
#### Prometheus
Monitoring database (https://prometheus.io/)
Ports:
- 9090: Metrics database (internal, for Grafana)
Volumes:
- ./prometheus/:/etc/prometheus/
- prometheusdata:/prometheus
#### Grafana
Observability platform (UI? https://grafana.com/)
Ports:
- 3000: Grafana metrics UI (internal)
Volumes:
- grafanadata:/var/lib/grafana
- ./grafana/datasources:/etc/grafana/provisioning/datasources
- ./grafana/dashboards:/etc/grafana/provisioning_temp/dashboards
### lighthouse.yml
Contains 2 services:
#### Lighthouse
The consensus client (https://lighthouse-book.sigmaprime.io/)
Ports:
- 5052: Beacon Node API (internal, https://lighthouse-book.sigmaprime.io/api-bn.html)
- 5053: never documented
- 5054: metrics (internal, for metrics exporter)
- 9000: P2P (public, conensus)
Volumes:
- lighthousedata:/root/.lighthouse
- ./jwttoken:/root/jwt:ro
#### Metrics Exporter
I think this prepares lighthouse metrics for Grafana (https://github.com/ethpandaops/ethereum-metrics-exporter)
Ports:
- 9091: metrics UI / database? (internal)
Volumes:
- ./ethereum-metrics-exporter/config.yaml:/root/config.yaml

## Troubleshooting

NAME                      CPU %     MEM USAGE / LIMIT     MEM %     NET I/O           BLOCK I/O
| lighthouse | 410.69% | 6.174GiB / 125.7GiB | 4.91% | 40GB / 7.88GB | 21.6MB / 1.9TB |
| reth | 240.16% | 4.701GiB / 125.7GiB | 3.74% | 30.3GB / 4.01GB | 393kB / 76.5GB |

|| NAME || CPU % || MEM USAGE / LIMIT || MEM % || NET I/O || BLOCK I/O ||
| lighthouse | 217.40% | 6.481GiB / 125.7GiB | 5.16% | 41.3GB / 8.51GB | 21.6MB / 1.96TB |
| reth | 369.21% | 3.141GiB / 125.7GiB | 2.50% | 32.3GB / 4.34GB | 393kB / 80.1GB |

Shutdown lighthouse and metrics-explorer services at 20:27 for bandwidth reasons.

### Try

Change docker-compose files to directly use the path (instead of named volumes; make it more similar to `docker ... -v local/path:/container/path)` . If the volume was the culprit, this would help.

Installed packages:   fio libgfapi0 libgfrpc0 libgfxdr0 libglusterfs0
