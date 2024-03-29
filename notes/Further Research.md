Ideas for further research, likely out of scope for this thesis, but still interesting.

## Compare with Mem-Pool

A frontrunning attack occurs, because a vulnerable transaction has been submitted but not yet executed. Usually, for public transactions, this vulnerable transaction is stored in the Mem-Pool.
Data for this is publicly available in a reasonable format: https://www.blocknative.com/data-archive-program

Research questions:
- When looking for TOD in the blockchain history, how many of them actually could be a frontrunning attack according to the mem-pool order (ie how often was $T_V$ submitted before $T_A$, but executed after $T_A$)?
- How do flashbots and other non-public transaction submissions play into this analysis?


## Non-EVM impact

This thesis only looks at frontrunning within Ethereum. However, any frontrunning attacks that also interact with the outside of the blockchain won't be noticed. For instance, if I submit a transaction to buy 1000 tokens of something, someone could use this information to buy stocks for this kind of real-world object. Arguably, this is not frontrunning anymore.