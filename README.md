## Goal

I want to analyze transactions to:
- check if they belong to a frontrunning attack
- extract metadata including:
    - frontrunning type + metadata
    - data that determines if it's easy/hard for tools to detect
    - data that makes it easy for humans to understand the attack

## Components

![Diagram](http://www.plantuml.com/plantuml/png/PP9HRjim38RVTGeYUsc0vGP5qIxBq07RMcH1NxB1O6msDgQ8XaHlyP33LnPZruO31BBuVoBrKxmFWbwQapMMZkGA4Ax1LyTI3CJVPSsM_GLsRKrmqT3j1zlfHq_jtGL-i43AGSKS81U9fqQ0Nq5AWWEVtw6MhEL_4VZgeFOSyH2YIgxGgnXJeE010y7YmUTbzPTYjO9-kPljPlUuN006G1Ko5mKOrJNxnoe8-nRGeMt_a__TuQK6ipu8rrkO_SwZ2vXBnGuyrHPRyjTAm1wscvVlovIY5oVL9iSd5UKyApRojJbNGIftX2uKI48i-IHbP6kioGSrILSgwwbnxKasFDMMuAMnZZmUREpLcfrup2MaJ7c_czvuiFk56rVuLfrgrEm_av1omcp1Dyub-ES9lNngZa7nJinKDCRSB67xlEwMnJCBEQdG0efW_aUl8k_rGy8UaWWX9uU-uWJfWQoF9MuN3T2G8oSz_GqFPCF7aNUOMhS9q0pCDi1hvOhOL5Mb2sNSIDs8CPEfMYKZyG-tgzNTR8JCRAOYDNLdvWyuPqQxA0zZPleFFQA6pV2ENNJMfVx0N9XdqZMoeq4rPjWetJVFw1hfyMCFtmfFUtbFhcXEzWq0)

**[History Analyzer](./notes/transactions/components/History%20Analyzer.md)** (eg python+SQL, using RPC), that:
- uses an archive node to filter out *potential* frontrunning attacks

**[Transaction Replayer](./notes/transactions/components/Transaction%20Replayer.md)** (REVM or wrapper for RPC), that:
- runs transactions based on a specific block state
- outputs transaction traces

**[Transaction Player](./notes/transactions/components/Transaction%20Player.md)** (eg customized Foundry), that:
- deploys minimal contracts
- setups the vulnerable state of the contracts
- runs 2+ transactions in different orders
- outputs transaction traces (or similar)

**[Transaction Analyzer](./notes/transactions/components/History%20Analyzer.md)** (python), that:
- takes transaction traces (or similar)
- checks if the transaction matches a frontrunning definition
- extracts attack metadata
- extracts labels

**[Detection Tool Runner](./notes/transactions/components/Detection%20Tool%20Runner.md)** (eg SmartBugs), that:
- takes smart contracts (or groups of them)
- checks which detection tools report TOD vulnerabilities for which contracts