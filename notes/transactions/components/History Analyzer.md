
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

## Definition remarks

Definition: Read something that was *recently* modified by another transaction

Remark for the definition: Without "recently" it would detect nearly everything. If a program reads a non-constant non-zero value, a previous transaction must have set this value.

Remark for the remark: This remark probably extends for all definitions (eg an Ether flow depends on the fact that the sender already got the ether from a previous transaction; a token transfer depends on the fact that the token was created previously).

"Recently" is a heuristic to identify the case that the attacker knew of the victim transaction before publishing their own transaction. If the attackers transaction happened 10 years earlier it's not possible that they knew of the victims transaction. If it happened 10 seconds earlier, it's certainly possible.
Sometimes it's also inherent to the data. For instance, if a contract was created and somebody makes a transaction to the contract address afterwards: The contract address is not known previously, so it can't be that the tx was first in the mem-pool, the attacker saw it and then quickly created the contract for this transaction first.