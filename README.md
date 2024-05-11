## Goal

I want to analyze transactions to:
- check if they belong to a frontrunning attack
- extract metadata including:
    - frontrunning type + metadata
    - data that determines if it's easy/hard for tools to detect
    - data that makes it easy for humans to understand the attack

## Components

![Diagram](http://www.plantuml.com/plantuml/png/PP9lRzCm4CRV-rESofjLejzWcZPAqP20JQNQcuAYQt9h8bmxEb-WGVtmNEmcIqYbAlRp_7n_phuFWYpDoHfBHt85YA-1gsCf1lHtMNlh-GAxjYQu9EdsdUty8rDxTu5lNY36e68Ea5FYgH7mho0bmS6Vtw2MhFL_5FZie6QlU0ZgQX6f56CA53nW85WyS5vMlqcp5VJ3tMmtkyVb0Z009YDpQi0ehza_La4yju0ERVkN-6U7bqdCUj7iTumkO2wLTy1KMso9hnd0CsmtBr-NyMXlJhECZqyooNb80jTMH_ripbf8vOwWaWeIDEMJbChMM1E7r1nTgQod9hd7qV1KMuANnZfYF5YTqTexOIqin4XvlvjMFBJxoJUku3PrcbIp_qX2YHFlBN3ZN8I_dv3bGtCC2U_CB9d6c9ibR9_NtMVnx8MSL6W1HJ3_bKgHj_mXOW_HX92JGwvyXDA1hDSYfuNdDCJGvJ3Npls21xBX_MW6C1s1ZK2Af1K7UArSeSDDhdHIvXkf6p5cygfMiI7zm-rgTJT_GlyBeDIqIpE_o3apsgazF3VJB_eZEIayt6UdpgRL7vWRyqZfg-pemHepR1BT3y-ahzBZIn_M2PxEyfvSqPpiFm00)

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