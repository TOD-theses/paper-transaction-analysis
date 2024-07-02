## Goal

I want to analyze transactions to:
- check if they belong to a frontrunning attack
- extract metadata including:
    - frontrunning type + metadata
    - data that determines if it's easy/hard for tools to detect
    - data that makes it easy for humans to understand the attack

## Components

![Diagram](http://www.plantuml.com/plantuml/png/PP9lRzCm4CRV-rESofjD8jy0JHjTqP20JgNQcuAYQt9h8rnVP5zWGVtmE7RTnAHIvVYvN-xFaxjtWbQwarQQ3cHg46x1DeUZAF2_yv8rspDi-vRW7AKFx_GGFrZgxyxmZGL23ghd01bFh3i1VWKv4kpvROHwqfh_UE2pWTQonvtpKTz4R4Mf6WNtw0WM3xOwDh_9LwlfXxdPhBPFjmj01nW3fV41cDHLkwV62TiUqA3k_vBzEU37A9P9X4iNQhUrQ1nMqh01Iwt6dkob4h25pUhbwsr8aO9vDVzwHIul9a6RrqfmYzRbQ5GIE9b_zUORRym11icHED_QMewURR4bww8PTA7AH6KzJhFXgTK4BvqsP76llQTBDaCJuaAcAjroOwwsVEBErBQFZaHLxHv9A7B2hC5snWJu-mcjVEmEBk93i8n1fTJDBMoUbyEnU6OX8mrgsAuVOnyo5dU1UH31wXUuYWpQXWE4GIkJ5hXeyMBqDgXVS4_QlPyC3ldSEW0n0xDsyDgOsZjwoJH89NVITg9Kjdf5cCB_eIZkPckc_XS2bGsdvXzlpanlK5nNKSM7b3REgwxVS51d9gKNve5vfdX2aQ-focxNw3Xq0hAXBmwhU4AHhSFu7E7Cy7ioTNVI_m00)

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