How do we find secure programs?

# Existing datasets

In the csg paper, we have following sets of secure contracts w.r.t SWC-114:

```csv
EthRacer;f;45
JiuZhou;f;2
NPChecker;f;34
Zeus;f;641
```

They highly likely have different definitions of frontrunning, which makes it at least not directly usable.

# Automatic Filtering

## Sound vs Complete

When we exclude potentially vulnerable contracts, (if possible) we want to be 100% sure that they are vulnerable. If it only was 90% sure and mark a contract as vulnerable, we could miss the 10% of secure contracts that look 90% vulnerable but actually are secure (which is pretty interesting).

As we want to be 100% sure that they are vulnerable, the vulnerability analysis should be sound (?).
## Transaction based

Similar to the "Vulnerabilities: Vulnerable Does Not Imply Exploited" paper, where they define (somewhat) "sound" requirements for an attack, and then look for transactions that fulfill this requirement.

Actually, is the paper providing "sound" requirements for an attack or "sound" requirements for a non-attack? I'd guess latter, which is not what I want :( 

We:
1. take contracts that were reported as vulnerable by the tools (at least n per contract)
2. take all executed transactions that work with these contracts
3. make a sound analysis (or heuristic) if the transactions could be an attack
	1. take transactions close to each other (eg within 3 blocks; else it's likely not feasible)
	2. extract writes to the environment (storage, balance, etc) - would modifications be better (and still be sound?)
	3. extract reads from the environment (storage, balance, etc)
	4. check if any write location matches a read location (eg same storage key)
	5. check if a reordering would modify the outcome
4. drop all contracts that have a potential attack
5. manually verify the remaining, likely not-attacked, contracts

Advantages:
- reuse of other tools to find potential attacks (and in turn, potential non-attacks)
- a limited set of contracts to manually verify:
	- only contracts marked as vulnerable
	- only contracts that haven't been attacked
Disadvantages:
- ...

## Contract based

We:
1. take contracts that were reported as vulnerable by the tools (at least n per contract)
2. apply sound analysis if the contract is vulnerable:
	1. contract uses some currency
3. drop all contracts that are potentially vulnerable
4. manually verify the remaining, likely non-vulnerable, contracts

Advantages:
- a limited set of contracts to manually verify:
	- only contracts marked as vulnerable
	- only contracts that don't seem vulnerable
Disadvantages:
- analysis of contract is nearly writing an own detector, likely harder than the analysis of transactions

## Contract+Transaction based

Same as above. Drop contracts based on contract analysis and corresponding transaction analysis.

Advantages:
- less contracts than when only dropping via a single source
Disadvantages:
- double the effort

# Manual Analysis

The automatic analysis will only give possible candidates, that have to be manually verified.
## Process

1. Create Definitions and Lemmas
2. If lemmas hold for each candidate
3. Mark as secure
## Definitions / Lemmas

The Nyx paper has some lemmas that need to be satisfied. Investigate this. Maybe create owns.
...