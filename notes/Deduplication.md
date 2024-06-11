
Code comparison for functions:
- build CFG from EVM bytecode
- get graph for specific function (somehow? Probably would need to use solidity semantics with if/else checks for the selector, and then take the jump destination)
- make skeleton from opcodes
- check opcode similarity
Comparison of traces:
- use JS tracer when tracing blocks
- run opcode trigrams, but per contract