Ideas for further research, likely out of scope for this thesis, but still interesting.

## Compare with Mem-Pool

A frontrunning attack occurs, because a vulnerable transaction has been submitted but not yet executed. Usually, for public transactions, this vulnerable transaction is stored in the Mem-Pool.
Data for this is publicly available in a reasonable format: https://www.blocknative.com/data-archive-program

Research questions:
- When looking for TOD in the blockchain history, how many of them actually could be a frontrunning attack according to the mem-pool order (ie how often was $T_V$ submitted before $T_A$, but executed after $T_A$)?
- How do flashbots and other non-public transaction submissions play into this analysis?


## Non-EVM impact

This thesis only looks at frontrunning within Ethereum. However, any frontrunning attacks that also interact with the outside of the blockchain won't be noticed. For instance, if I submit a transaction to buy 1000 tokens of something, someone could use this information to buy stocks for this kind of real-world object. Arguably, this is not frontrunning anymore.

## Automatic minimal reproducible example creation

Initial question:
Given a trace $T = \{I_0, I_1, \dots, I_n\}$ that falls in a TOD definition $D_{TOD}$. What is the minimal subset of instructions $T\prime \subset T$ , that still fulfills $D_{TOD}$?

Could we drop instructions in such a way, that the trace could come from an actual program? That it stays realistic?

If yes, could we use this to collect different patterns of the same TOD, learning more about it? Or would it always reduce to the same pattern, essentially describing the definition in a minimal set of instructions?

How many instructions could we remove from the end, until it doesn't fulfill the definition anymore? -> I can do this likely anyway, removing everything after the sink.

Is the influence trace a minimal reproducible example?

## TOD Trace Visualization

Visualize / Display clearly, how the TOD occurred.

For instance, take the influence trace, and display all changed instructions and call frames (pseudo trace):

```
Attacker:
swap(...):
  ...
  buy(token, amount)
    ...
    SSTORE key **changed value**

Victim:
swap(...):
  ...
  get_reserves():
    ...
    SLOAD key -> **changed value**
    ...
    RETURN -> **changed value**
  --> returns **changed value**
  ...
  RETURNDATACOPY -> **changed value**
  ...
  buy(token, **changed amount**):
    ...
    LOG Transfer(from, to, **changed amount**)
```

This could already help at understanding what happens. Which contracts are affected, where we would consider the vulnerability.
If feasible, this could also be mapped back to the Solidity source files, for even easier understanding.