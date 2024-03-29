## Goal

I want to analyze transactions to:
- check if they belong to a frontrunning attack
- extract metadata including:
    - frontrunning type + metadata
    - data that determines if it's easy/hard for tools to detect
    - data that makes it easy for humans to understand the attack

## Components

![Diagram](http://www.plantuml.com/plantuml/png/RP9FR_8m3CRl-HGMxmKE_GQl9X1Ysc5_49guiAaogGNHGb8bxaRtwHUI9QFh3bNInpy_iPtCFQFZxgH5Wunxz0IJXPD7zKxmQ1jwCTELKmThPXD03vX2jGaXiRjJdgth0Gtg_fFSwmKv9h7EejWzEpGU9Ijhm56hiISNV3UhxSCifcGH_lMajVqOfWpS-LoC2trL-keSJbVc044A0ljmpXCV0znYIywdBkYRgZFrjnMUMasmxRGXXtiTPh6qXXrAzj56vhzXlQN1MzkPnlMfnwGA8QOpsAoNbsMojao65Mf0PfHloPP_l4fX4Lz42BmaWqxP2AV4EckH2yL8AbwIXYxtk2UTeZfkXRY-LQXYUU63_rLrCxxEtm84Qb2p4EFvZfb1brLv0Y9lSega09T9NzHHppbX71WxfHMgwuSaoZx1UIvpCartqby0)

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
