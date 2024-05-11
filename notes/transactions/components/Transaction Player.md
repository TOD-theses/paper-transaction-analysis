## Goal

I want to create EIP-3155 traces for some test contracts.

This includes:
- setup some contracts (with ether and maybe some initial calls)
- make transaction 1 and get a EIP-3155 trace of it
- make transaction 2 and get a EIP-3155 trace of it

If possible, easily automatable and integrated into the forge tests / scripts.
## Implementation Ideas

### forge scripts + anvil
Use forge scripts to make RPC calls for:
- contract creation
- contract setup
- tx 1
- tx 2
- reset
- tx 2
- tx 1

Potentially split this into two script calls (one for each order).

Then get the traces from anvil with `debug_trace_call(...)` (at least this works in the anvil traces test).

### forge test + custom cheatcode

Implement custom `traceStart` and `traceEnd` cheatcodes to create traces from within the tests.
In the traces_analyzer, I'd likely need to 