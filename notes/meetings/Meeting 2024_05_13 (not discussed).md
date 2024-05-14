### Notes

### Last weeks

#### Trace parser with data flow analysis

Implemented data flow analysis (for taint analysis):
- keep track which instruction created data ("bytes 0xabcdef were created at step 1234")
- keep creation data when moving data between storages (ie copy the bytes+metadata):
    - stack
    - memory
    - calldata
    - callvalue (TBD)
    - returndata
    - balances
- create data flow graph with each step as a node:
    - the parents are steps that produced the accessed data (eg `SLOAD` if it in/directly used the storage value as input)
    - the children are steps that accessed the produced data

This allows to:
- make a source $\rightarrow$ sink analysis:
    - the `SLOAD` at step 1234 caused an input change in the `CALL` instruction
    - the return data from call ABC caused an input change in the `LOG` instruction
    - the contracts touched between source and sink are `0x1234`, `0xabcd`, ...
- make more complex labels:
    - is the output of a hash function used for a comparison? (or only for a solidity mapping access `users[address]`?)
    - is the `msg.sender` verified? (ie, does a comparison in/directly depend on it?)

### Next steps

Next 2-3 weeks:
- Setup archive node
- Finish trace parser implementation
- Compare preliminary analyzer against [Combatting paper benchmark](https://ieeexplore.ieee.org/document/10108045)
- start with history analyzer

On the 26.6.: FMI exam :)

Outlook:
- history analyzer:
    - write up related work for attack mining
    - implement attack mining (RPC to get stateDiffs and accessed state for each transaction; python script + SQL to store and analyze them)
    - compare attack mining against Combatting paper benchmark (would it mark all benchmarked attacks as possible attacks)
- traces analyzer:
    - implement categorization of attacks into various TOD definitions
    - implement other label extraction (opcodes, source of TOD, currency type, precompiled contracts, etc.)
    - compare trace analysis against Combatting paper benchmark (does it yield the same results, for the parts that are comparable?)
- analyze mined attacks:
    - combine history analyzer with traces analyzer
    - store results in a csv/...
- mempool analysis (probably out of scope for time reasons):
    - check if attack transactions were broadcasted after victim transactions (compare against [Blocknative Mempool Archive](https://docs.blocknative.com/blocknative-data-archive/mempool-archive))
- tool evaluation:
    - run detection tools (Mythril, ...) against the attacked contracts
    - correlate results against attack labels