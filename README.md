## Goal

I want to analyze transactions to:
- check if they belong to a frontrunning attack
- extract metadata including:
    - frontrunning type + metadata
    - data that determines if it's easy/hard for tools to detect
    - data that makes it easy for humans to understand the attack

## Components

![Diagram](http://www.plantuml.com/plantuml/png/RPBFZjCm4CRlVefHkMmbyWO8xR8KSU3FQa5xAIYQEaDhuOuZUm8DJuzZRvoQSAYSVlFpPy_dkGs2NeQpLHqA7Z0GREwyFfbV19zSHz_uPkVDqV5s0nW0SwdbM5BxzoQ8yoCWent_aFy-8QSijhEezbyzSa0jnZ5uwYsEvAFlu-xfutRQKaHuCPArxdUzfNANIp4kz7BptSK4CNo4IGea8HxpMKwHxR4d7t8Jz4orC_LV9pptbk1fi4mU3pOcSUzOF6e9oKNF_-hRblRUkO4xF-OEiwhsRqaeS-AS1Jym9_ZB6Rsy6OuXurEnpKMbrCqM7X_kfsNpu8HO35f04TG_yrLaER_qal2x147GnEYDIt3UsCvQuc83cegNfjhb0nx8XfTNMK0TXKr0TdBE1lXXk8i1FpjEKki6wGTHwdg2e4cDnH-yQfhNwz7vLu18LTqgjNxCDLFbqvHnK_bZiTKKuVAkaxfAQzwmBgoTyWhDzT16zLArCuUdyWfDzVZBTuRhB6-9k-5i_m80)

**[History Analyzer](./notes/transactions/components/History%20Analyzer.md)** (eg python), that:
- uses an archive node to filter out *potential* frontrunning attacks

**[Transaction Replayer](./notes/transactions/components/Transaction%20Replayer.md)** (eg REVM), that:
- runs transactions based on a specific block state
- outputs transaction traces (or similar)

**[Transaction Player](./notes/transactions/components/Transaction%20Player.md)** (eg customized Foundry), that:
- deploys minimal contracts
- setups the vulnerable state of the contracts
- runs 2+ transactions in different orders
- outputs transaction traces (or similar)

**[Transaction Analyzer](./notes/transactions/components/History%20Analyzer.md)** (eg python), that:
- takes transaction traces (or similar)
- checks if the transaction matches a frontrunning definition
- extracts attack metadata
- extracts labels

**[Detection Tool Runner](./notes/transactions/components/Detection%20Tool%20Runner.md)** (eg SmartBugs), that:
- takes smart contracts (or groups of them)
- checks which detection tools report TOD vulnerabilities for which contracts