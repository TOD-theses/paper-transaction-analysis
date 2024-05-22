
## Detection Ideas

#### StateDiff + read

Definition: Read something that was *recently* modified by another transaction

This gets all transaction pairs, where the state change of one transaction modifies the execution of the other.

1. Use the RPC methods to get a statediff + complete trace of each transaction
2. Store all (or recent) statediffs in a lookup table with: (block_num, tx_num, contract, addr)
3. For each trace:
    1. For each read operation with address $(contract, addr)$:
        1. If there is an earlier statediff with the same $(contract, addr)$:
            1. Mark as potential TOD

Considerations:
- depending on the implementation of statediff and the trace evaluation:
    - could miss dependencies on ether balances
    - could miss dependencies on contract existence (eg through selfdestruct)
    - could miss dependencies on something I forgot about (would need to check of what exactly the state consists, thus what can impact the transaction)

Exclusions:
- both transactions from the same sender (with the tx nonce, it's not possible the order would get changed)
- contract creation + tx to the contract (no one would make a transaction to a contract before it was created)
- transaction only sends value, no other statediff (TODO: rethink this)

Note: Maybe the archive node already stores all these state diffs in a database, for easier lookup? If yes, we could simply use that :)
And if not, maybe we can modify the node to store this data in a database on the first sync?

#### Accessed state overlaps

Consider it a potential attack, if two transactions accessed the same state (storage, balance, ...). This would also include read-reads (which are no attacks), however it's probably easier to implement. Research could be done, how much difference there is to other pruning approaches.

For this, we could use prestate tracers, or maybe also `accessList`.

Maybe check how much `accessList` is used and how often it truly reflects the accessed state: https://eips.ethereum.org/EIPS/eip-2930

## Archive Nodes

https://ethernodes.org/
However, Geth, Nethermind and Besu require much more space than Erigon and Reth (~2TB vs 12+TB).
### Hardware

https://paradigmxyz.github.io/reth/installation/installation.html
https://gist.github.com/yorickdowne/f3a3e79a573bf35767cd002cc977b038

|           |                                       |
| --------- | ------------------------------------- |
| Disk      | At least 2.2TB (TLC NVMe recommended) |
| Memory    | 8GB+                                  |
| CPU       | Higher clock speed over core count    |
| Bandwidth | Stable 24Mbps+                        |

### Erigon

Likely benefits: fast to sync, widely used
Recommend auf [ethereum.org](https://ethereum.org/en/developers/docs/nodes-and-clients/archive-nodes/#recommended-practices).

Seems to store access sets on a block level: https://github.com/ledgerwatch/erigon/blob/devel/docs/programmers_guide/db_walkthrough.MD


### RETH

Likely benefits: fast to sync, fast to replay

Same developers as foundry, also backed by REVM.

The database seems NOT to store access sets on a transaction level, only on a block level. Thus, I think it would need to re-execute each transaction to get this info. See `.../tables/mod.rs`.

The debug tracing is implemented at `crates/rpc/rpc/src/debug.rs` and uses `revm` to replay the transactions.

Prestate is probably enough. It includes everything that was touched (even if it was not modified in the normal mode).

### Reth via Merkle
https://freerpc.merkle.io/

Sync starting from snapshot: https://blog.merkle.io/blog/reth-snapshots-faster-syncing-ethereum
https://blog.merkle.io/blog/run-a-reth-node

