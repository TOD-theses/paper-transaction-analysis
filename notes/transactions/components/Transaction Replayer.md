
Currently, we pass REVM a client that fetches the necessary data on demand from an archive node.

We could rewrite it, to take (or fetch) the prestate¹ for a transaction, then seed the database cache with it. This should allow to run REVM offline which should be magnitudes faster and also good for reproducibility.

Q: Is it a problem, that we move transactions to different places / orders? Doesn't this change the required prestate? OR, is it actually enough to change the prestate according to the stateDiff of the other transaction?
For instance:
- real world was tx (A, ..., B)
- we fetch the prestates $P_A$ and $P_B$ from an archive node (see [prestateTracer](https://geth.ethereum.org/docs/developers/evm-tracing/built-in-tracers#prestate-tracer))
- we set $P_A\prime$ = $P_A$ and then apply $P_B$ on it (ie overwrite all values in $P_A$ with $P_B$, even if $P_A$ did not use them)
- we execute tx A and initialize the DB cache with $P_A\prime$.

We still would need to make sure, that the environment is good though (though with a simulate RPC method, maybe even this can be done by the archive node :)

## stateOverrides

See https://geth.ethereum.org/docs/interacting-with-geth/rpc/ns-debug#debugtracecall

Actual execution $A \rightarrow B$:
1. $A$ was executed with the prestate $P$  and produced stateDiff $SD_A$
2. $B$ was executed with the prestate $P + SD_A$ 
Simulation:
1. Trace $B$ with stateOverrides $P$
2. Get stateDiff $SD_B$ from the trace
3. Trace $A$ with stateOverrides $P + SD_B$