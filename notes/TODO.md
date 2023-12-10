### Displacement - vulnerable code detection

Detection with symbolic execution:
- execute until send(...) - simplify constraints - check if constraints include transaction.sender

Questions:
- is using `block.blockhash(block.number) == guess` vulnerable to frontrunning?


Frontrunning (at least Displacement) is the act of using tx information to create new transactions and make profit out of it. If a tool could automatically create an attack, would it skip the act of using tx information? If it can solve a puzzle contract without any additional input, it's a puzzle solver, not a frontrunning detector? Or both? And if it only solves it for a specific self-created instance of this puzzle (eg secret = keccak256(1234)), what about this? In displacement, the original tx doesn't even need to occur, so I don't think symbolic execution approaches would consider this. 