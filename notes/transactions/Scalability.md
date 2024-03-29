## Replayer

For the Zhang et al. benchmark, one nearly complete run until the Infura rate limit. Around 12% of the transactions failed due to bugs or expected failure.

|               | Actual | Per hour | Per attack | For 100GB .tar.gz |
| ------------- | ------ | -------- | ---------- | ----------------- |
| Time          | 52m    | 60m      | 20s        | 14 days           |
| Attacks       | 154    | 178      | 1          | 60.000            |
| Transactions  | 622    | 718      | 4.03       | 250.000           |
| API requests  | 23.682 | 27.325   | 150        | 9.500.000         |
| output        | 16GB   | 18.5GB   | 106MB      | 6 TB              |
| output.tar.gz | 260MB  | 300MB    | 2MB        | 100GB             |

## Traces Analyzer

|         | Actual | For 100GB traces.tar.gz |
| ------- | ------ | ----------------------- |
| Time    | 2m     | 13h                     |
| Attacks | 154    | 60.000                  |
| output  | 64MB   | 24GB                    |
