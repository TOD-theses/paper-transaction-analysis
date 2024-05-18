## Replayer

Creating traces with complete stack and memory for each step, using REVM with RPC caching and the Merkle API:

|               | Actual | Per attack | For 10.000 attacks |
| ------------- | -----: | ---------: | -----------------: |
| Time          |    20m |        12s |           1.4 days |
| Attacks       |    100 |          1 |             10.000 |
| API requests  |    10k |        100 |              1000k |
| API price     | € 0.07 |      0.07c |                 7€ |
| output        |  13 GB |     130 MB |             1.3 TB |
| output.tar.gz | 0.2 GB |       2 MB |              20 GB |
| RPC cache     |  10 MB |     0.1 MB |               1 GB |

## Traces Analyzer

|                  | Actual | Per attack | For 10.000 attacks |
| ---------------- | -----: | ---------: | -----------------: |
| Time             |    40m |        12s |           1.4 days |
| Attacks          |    200 |          1 |             10.000 |
| (current output) | 0.4 GB |       2 MB |              20 GB |

## TOD Attack Miner

TOD-O

