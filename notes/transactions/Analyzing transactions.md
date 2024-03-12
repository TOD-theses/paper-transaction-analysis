## Goal

I want to analyze transactions to:

1. understand which functions are executed (hashing, etc)
2. understand if the execution flow changed
3. understand which environment loads differ (first SLOAD/BALANCE/... that returns a different value. what about contract calls reverting, eg if one tx selfdestructs? -> go through all EVM instructions to determine which depend on the environment)
4. ...?


# How

## Overview

I want to:
- setup the environment via:
	- forking at specific block
	- or creating example contracts + setup
- run two transactions
- get the [EIP-3155 Traces](https://eips.ethereum.org/EIPS/eip-3155) execution traces (or a similar format)
- analyze the traces via python/etc.

TODO:
- what if the execution semantic changed? ie SELFDESTRUCT pre 13.3.2024 and post 13.3.2024 has different semantics. Would I need to use different versions of the EVM? How often does this happen?

## Getting the initial state

There are many online services that provide archive nodes, which can then be linked locally (using forks in foundry's anvil, geth, etc). There you can also specify a specific block.

For a specific transaction within a block, you'd likely need to execute all transactions after the block start.

I don't necessarily need an archive node, a snapshot at a specific state should be sufficient to replay all transactions following it. Maybe this is more difficult and error-prone though.

## Analyzing transactions

This seems a bit trickier, but also doable.

### Geth / Anvil

If the transaction is stored in the network, the `debug_traceTransaction` RPC will replay the tx and return all executed steps. This seems easy for published transactions. For custom transactions, I probably need to publish them first.

Trying this with anvil did not succeed (see appendix below). EDIT: This call is not implemented on Infura, maybe check Quicknode. Also, I'd like to do this locally (with my own tx order), so can this be executed by the local geth/anvil/... client?
https://geth.ethereum.org/docs/developers/evm-tracing/built-in-tracers
Also check `debug_traceBlockByHash`.

### Foundry

I would likely need to create a new cheatcode `startMyOwnRecording()` + `stopMyOwnRecording()` and add inspector hooks in `cheatcodes/src/evm.rs`. Seems doable, but I should determine the requirements first, then raise a github issue and then start working on it.

Foundry tests only display the internal calls, not every step. The debug mode (eg `--debug Increment`) displays all executed steps, however it does not seem to expose this programmatically.

Maybe I could also use foundry to publish transactions.

The `cast run {tx_hash}` only prints the internal call trace and cannot be called on non-published transactions I think.


### Revm

With REVM I can use eg the Infura API to fork the blockchain at a specific point, and then replay any transaction.
I've tested it to replay all transactions from a block, it took
- ~20 minutes
- ~200 transactions
- ~1700 API requests (~7% of the 25.000 archive requests per day).
This would translate to roughly 2.800 transactions per day (limited by the API).


# Appendix

## Anvil cast

```
# note: took around 10m with 4500 requests to Infura and executed 320 prior transactions
# the quick version below only took a few seconds with 32 requests

oaie:~$ cast run 0xf14059a2047a2848d161044a7419fc7a82291e807c18e8619e71a2b66e980cc3
Executing previous transactions from the block.
Traces:
  [22685] 0xf26BC97Aa8AFE176e275Cf3b08c363f09De371fA::approve(0x73DA73EF3a6982109c4d5BDb0dB9dd3E3783f313,
 2000)
    └─ ← 0x0000000000000000000000000000000000000000000000000000000000000001


Transaction successfully executed.
Gas used: 44269

oaie:~/thesis$ cast run -q 0x94bf6d6375d0947559494b08f85d5f29b3b3c39aa0b6f0103dc950094a531c69
Traces:
  [58276] 0xd5c0A6094f005D75b6E99a3DA8d0B80127027C99::claimReward()
    ├─ [2902] 0x5005e8Dc0033E78AF80cfc8d10f5163f2FcF0E79::positions(0xb065e2015b2D35F4A9B7e0cf71BD24bEeCa270b9) [staticcall]
    │   └─ ← 0x0000000000000000000000000000000000000000000000010be8acc97ca1c27c000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000028590000
000000000000000000000000000000000000000000000000000061106cba0000000000000000000000000000000000000000000000000000000061106cba
    ├─ emit Claimed(param0: 0xb065e2015b2D35F4A9B7e0cf71BD24bEeCa270b9, param1: 228724090000000000000 [2.287e20])
    ├─ [13085] 0xeEAA40B28A2d1b0B08f6f97bB1DD4B75316c6107::transfer(0xb065e2015b2D35F4A9B7e0cf71BD24bEeCa270b9, 228724090000000000000 [2.287e20])
    │   ├─ emit Transfer(param0: 0xd5c0A6094f005D75b6E99a3DA8d0B80127027C99, param1: 0xb065e2015b2D35F4A9B7e0cf71BD24bEeCa270b9, param2: 228724090000000000000 [2.287e20])
    │   └─ ← 0x0000000000000000000000000000000000000000000000000000000000000001
    └─ ← ()


Transaction successfully executed.
Gas used: 79340
```