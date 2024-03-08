
# Attack Types

Withdraw (eg via password) =?= SWC 105

Arbitrage (amount depends on some price -> exact definition is hard; is arbitrage the correct term?) -> only values are changed; control flow stays the same

Recipient change (state variable change, except proxy)

Implementation change (proxies, etc)

## Environment Change

How does the transaction affect / is affected by the environment? (ie why does the reordering matter?)

- Contracts own storage (the classic)
- Contracts own balance (eg if the payout for Casino is possible in EthRacer; this can be implicitly by trying to send X ether resulting in an error due to insufficient ether)
- Existence of other contract
- ...

# Currency Type

Ether
Token-ABC

# Preconditions

None

Owner -> exact definition is hard (can the attack be performed by an arbitrary address? previous interaction necessary?)

# Complexity

Hashing

Signing

opcode-ABC

# Solidity Version

range?

# Other
Is ERC-20 approval already covered somewhere?

Contract Functionality Type, like Zeus did (DAO, Game, Token, Wallet, Common policy)