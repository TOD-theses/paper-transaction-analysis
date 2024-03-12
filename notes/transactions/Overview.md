## Goal

I want to analyze transactions to:
- check if they belong to a frontrunning attack
- extract metadata including:
    - frontrunning type + metadata
    - data that determines if it's easy/hard for tools to detect
    - data that makes it easy for humans to understand the attack

## Components

![Diagram](http://www.plantuml.com/plantuml/png/RLBBRW8n3BpdAonESDW_g2eGekgX3uGgBhHQcQm5KKEoSap5zkiRaWRORWzHdF5uDBOp3O8inuDL3GfkCH2CPgptvelWnJVqxiOBDZll9YF009XJjOifjNaqGJntW0vjzqtySQRiCrWNK6tU65r0BSOxO6ejTiHHTxLOFqzIIG7xr9wgdAw2DrON9nF4k1sSeK0Iekwhx8cXnPOuPDVqoweBgo-1XzOIh8_M4UFMnfxdtWcZbf3ATNdr_LqQUV17rt2NUyceKceyWTLoVhv6Io_anA05547zcMNbgXKIRPQI43GvPECJAHVK1KkyQ4BJHIE62Nt2BTcCsXGgTRijg9ATUE2kgkw7Q_eBG6JrFQh17F_XtBwWkgus1rcss5Pbiabeq6if62Q6Ilc6glTHBd4cbxbCoJNnn_y0)

**[[History Analyzer]]** (eg python, datalog), that:
- uses an archive node to filter out *potential* frontrunning attacks

**[[Transaction Replayer]]** (eg REVM), that:
- runs transactions based on a specific block state
- outputs transaction traces (or similar)

**[[Transaction Player]]** (eg customized Foundry), that:
- deploys minimal contracts
- setups the vulnerable state of the contracts
- runs 2+ transactions in different orders
- outputs transaction traces (or similar)

**[[Transaction Analyzer]]** (eg python, datalog, ...), that:
- takes transaction traces (or similar)
- checks if the transaction matches a frontrunning definition
- extracts attack metadata
- extracts labels
