## Goal

Take attack traces and output labels and other metadata.

## Labels

### Frontrunning definition
Multiselect of which frontrunning definitions would mark this as an attack.

TOD-Amount, TOD-Recipient, TOD-Transfer, TOD-Selfdestruct
Change of internal transactions
Attacker Profit / Victim Profit

Maybe it's better to split this into multiple labels and reason about the definitions later on.

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

This is probably easier to check if the replayer runs $T_A$ from both, the attackers address and from an arbitrary address. If the traces are equal, it doesn't matter who attacks. If the traces are not equal, it probably matters (or maybe then we'd need to update the attack input).
### Control Flow
Whether the control flow changed due to the attack or not.
### Used opcodes
A list of used opcodes that could make it hard for detection tools:
- hashing
- signing
- "new" opcodes

## Other metadata

Net profits and losses (ether, tokens).

Program Counter where the change occurred (eg SLOAD).

Program Counter where a change in the control flow occurred.

List of impacted storage variables (which have a different value because of the attacker transactoin).
