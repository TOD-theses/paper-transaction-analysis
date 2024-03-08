A semi-structured list of tools that may or may not detect TOD contracts. 

### Supported Tools

TODO: NYX (https://github.com/Troublor/Nyx)

||detects TOD|version|Solidity|bytecode|runtime code|
|---|---|---|---|---|---|
|[ConFuzzius](https://github.com/christoftorres/ConFuzzius)|YES|#4315fb7 v0.0.1|:heavy_check_mark:|||
|[Conkas](https://github.com/smartbugs/conkas)|YES|#4e0f256|:heavy_check_mark:||:heavy_check_mark:|
|[Ethainter](https://zenodo.org/record/3760403)|no||||:heavy_check_mark:|
|[eThor](https://secpriv.wien/ethor)|no|2023|||:heavy_check_mark:|
|[HoneyBadger](https://github.com/christoftorres/HoneyBadger)|no|#ff30c9a|:heavy_check_mark:||:heavy_check_mark:|
|[MadMax](https://github.com/nevillegrech/MadMax)|no|#6e9a6e9|||:heavy_check_mark:|
|[Maian](https://github.com/smartbugs/MAIAN)|KINDA|#4bab09a|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|
|[Manticore](https://github.com/trailofbits/manticore)|YES|0.3.7|:heavy_check_mark:|||
|[Mythril](https://github.com/ConsenSys/mythril)|KINDA|0.23.15|:heavy_check_mark:|:heavy_check_mark:|:heavy_check_mark:|
|[Osiris](https://github.com/christoftorres/Osiris)|KINDA|#d1ecc37|:heavy_check_mark:||:heavy_check_mark:|
|[Oyente](https://github.com/smartbugs/oyente)|YES|#480e725|:heavy_check_mark:||:heavy_check_mark:|
|[Pakala](https://github.com/palkeo/pakala)|YES|#c84ef38 v1.1.10|||:heavy_check_mark:|
|[Securify](https://github.com/eth-sri/securify)|YES||:heavy_check_mark:||:heavy_check_mark:|
|[Semgrep](https://github.com/Decurity/semgrep-smart-contracts)|no|#c3a9f40|:heavy_check_mark:|||
|[sFuzz](https://github.com/duytai/sFuzz)|no|#48934c0 (2019-03-01)|:heavy_check_mark:|||
|[Slither](https://github.com/crytic/slither)|KINDA||:heavy_check_mark:|||
|[Smartcheck](https://github.com/smartdec/smartcheck)|no||:heavy_check_mark:|||
|[Solhint](https://github.com/protofire/solhint)|no|3.3.8|:heavy_check_mark:|||
|[teEther](https://github.com/nescio007/teether)|KINDA|#04adf56|||:heavy_check_mark:|
|[Vandal](https://github.com/usyd-blockchain/vandal)|KINDA|#d2b0043|||:heavy_check_mark:|


Securify2
KEVM

### ConFuzzius
Uses: A little bit of everything (Fuzzing, symbolic taint execution, data dependency).

### Conkas
Uses: Symbolic execution

### Ethainter
Uses: static; information flow, taint analysis

=> read to understand some static analysis concepts

### eThor
Uses: sound static analysis with z3

=> potential candidate for implementation

### Maian
Uses: symbolic analysis + concrete validation

=> Also checks for arbitrary send (Prodigal Contracts)
=> see example Contracts (maybe don't fall in the Displacement definition, still interesting; in particular the false positive could be used as a sample)

### Manticore
Uses: symbolic analysis + tainted values

See DetectExternalCallAndLeak => checks if there is a CALL to a more or less arbitrary address
See DetectDelegatecall

The Detect Race Condition only checks if func X reads a value tainted by func Y, potentially leading to a race condition. (See https://github.com/trailofbits/manticore/issues/1260 and https://github.com/trailofbits/manticore/blob/master/manticore/ethereum/detectors.py#L810). It DOES NOT check for the classic puzzle frontrunning, which does not require reading from the state.

### Osiris
Based on Oyente, does not add relevant stuff

### Oyente
Uses: symbolic execution

Checks if two execution paths (or transaction orders???) have different money flows. Should be able to detect this vulnerability if it doesn't timeout on hashes, etc.

### Pakala
Uses: symbolic execution

Tries to get money out to an arbitrary address (send and suicide)


### Securify(2)
Uses: ?

Implements both, TOD and SWC-105 (arbitrary send)

### Slither
Uses: static analysis, taint analysis

Detects arbitrary send => Displacement

### teEther
Uses: symbolic execution

Detects arbitrary send/... => Displacement
Looks kinda oooooold

### Vandal
Uses: Intermediary Representation + Datalog/Souffle = ?

Detects arbitrary send => Displacement