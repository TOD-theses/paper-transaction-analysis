## Goal

Take attack traces and output labels and other metadata.

## Labels

### Frontrunning definition
Multiselect of which frontrunning definitions would mark this as an attack.

TOD-Amount, TOD-Recipient, TOD-Transfer, TOD-Selfdestruct
Change of internal transactions
Attacker Profit / Victim Profit

Maybe it's better to split this into multiple labels and reason about the definitions later on.

### Vulnerable contracts
Which contracts from this trace are vulnerable to TOD?

I consider a contract vulnerable, if the same input resulted in a different execution:
- in the trace they are called with the same inputs
- their execution differs based on the transaction order

TODO: should this be one level above, such that every other label is attached to a specific contract instead of the whole trace? eg "contract X" is vulnerable to TOD-Amount instead of "this trace" is vulnerable to TOD-Amount.

### Impact
Loss of currency: ether/token
Unknown
### Environment Change
Which part of the State affected the victim transaction?
- contract storage?
- contract balance?
- EOA balance?
- existence of contract?
- ...?
### Preconditions
Attacker-known: the address from the attacker was returned from a SLOAD or a SLOAD with the attackers address as index returned != 0? Maybe hard to understand without information flow analysis.

This is probably easier to check if the replayer runs $T_A$ from both, the attackers address and from an arbitrary address. If the traces are equal, it doesn't matter who attacks. If the traces are not equal, it probably matters (or maybe then we'd need to update the attack input). BUT, this won't work if the attacker used bot contracts, eg to get some WETH for this attack.
### Control Flow
Whether the control flow changed due to the attack or not.
### Used opcodes
A list of used opcodes that could make it hard for detection tools:
- hashing
- signing
- "new" opcodes

## Attack symmetry

Is both $T_A \rightarrow T_V$ and $T_V \rightarrow T_A$ an attack? ie, if it was in the "non-attack" order $T_V \rightarrow T_A$, would this be an attack with the roles swapped?
## Other metadata

Net profits and losses (ether, tokens).

Program Counter where the change occurred (eg SLOAD).

Program Counter where a change in the control flow occurred.

List of impacted storage variables (which have a different value because of the attacker transactoin).
