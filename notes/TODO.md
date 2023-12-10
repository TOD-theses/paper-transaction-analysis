> Since changing the order between the client transaction and attacker transaction affect the final outcome of the latter, this means that the client transaction outcome is dependent on a state variable that the attacker transaction modifies.
> Automated Auditing of Ponzi Scheme Smart Contract TOD Vulnerabilities , 2017, p. 2

What exactly can these "state variable" be in reality? Go back to the Ethereum model and check on what a transaction can depend on (state, balances, block-environment, etc?). I think only relying on contract state misses a lot, at least in theory.


Read the EtherFuzz paper, section Related Works. Make a list of Tools somewhere


## Alternative Ideas

### Displacement - vulnerable code detection

Implement a puzzle-solver-detection TOD detection: Analyze if a function call that "solves a puzzle" results in a payout to an arbitrary address (the sender for simplicity). Solving a puzzle could mean to pass arguments such that an equation holds (not including metadata such as who makes this transaction, as this could be used to verify the owner). This puzzle solving would need to abstract away hash functions (as they can't be solved by the detection algorithm).

Example code:

```solidity
storage (uint => unit) # maps puzzle hash to award

function submit_solution(solution uint, puzzle_id uint)
{
   if (storage[puzzle_id] == puzzle(solution))
   {
	   storage[puzzle_id] = 0
	   send(transaction.sender, storage[puzzle_id])
   }
}

function puzzle(input uint)
{
   return keccak(input)
}
```

But how could I distinguish this from a "withdraw" by redeem code? Well, a "withdraw" by redeem code is also vulnerable.

Requirements:
- transaction.sender not used for if statements or indexes (-> anyone can frontrun this transaction)
- with some inputs and some state the function sends money to an arbitrary address (eg transaction.sender, or additional parameter)

Detection with symbolic execution:
- execute until send(...) - simplify constraints - check if constraints include transaction.sender

Detection with static analysis:
```
def analyze_code_block(code):
  for statement in code:
    if (is_send(statement) && sends_to_arbitrary_address(statement)) {
	    return true
    }
    if (is_condition(statement) && does_not_include_sender(statement)) {
      analyze_code_block(condition_inner_code(statement))
    }
    if (is_function(statement)) {
	  analyze_code_block(function_inner_code(statement))
    }
  return false
```
Everything here seems pretty straightforward, except for the sends_to_arbitrary_address. For starters I could restrict it to transaction.sender.

Fails at:
- signature: user signs the destination address in the transaction -> whitelist anything that depends on signed data for the destination address (see contract https://etherscan.io/address/0x3f1603602e870BD4c6953333B35eC988eEde4f9C, victim tx https://etherscan.io/tx/0xda293e44907f7a004cc9f132aadd4e08ee2f0a1befa1fc1aa0c21f253e6ce27c, attacker tx https://etherscan.io/tx/0x03c6fd44d57d62ae1f97d203ab50e3970a8c56ac9c1c3319a3d2e27ec965024b). Signing only the use (!= destination) is not sufficient, as someone could still frontrun this. Overthink all of this and look at all usages of signing data.
- calling other contracts (eg sending tokens via a Token Contract) -> consider to define sinks for function signatures / interfaces. This allows checking also for external calls to sinks (eg for `transfer(address _to, uint256 _value)` both values are sinks - if the user controls them without any check that's bad)

Questions:
- What is the difference to Slithers "arbitrary-send", which detects sends to (msg.sender, ...)? I guess the detection (code pattern) is pretty much the same, only the exploitation and fix would be different. An "arbitrary_send" detection won't convince the developer to implement a front-running prevention.
- is using `block.blockhash(block.number) == guess` vulnerable to frontrunning?
- What's the difference to https://swcregistry.io/docs/SWC-105/ ?


Sinks for arbitrage:
```
Arbitrage:

[Attacker]: Buy X tokens => changes state(...)
[Victim]: Buy X tokens => changes state(...)
[Attacker]: Sell X tokens => profit
```

Wait, is every market place "vulnerable" according to the paper definition?:
```
Buy_a(X, 10, expected=100) -> Buy_v(X, 20, expected=110) -> Sell_a(X, 10, expected=130)
balance(v) = original (little less as someone else sold)
balance(a) = original (little more as someone else bought in between)

vs

Buy_v(X, 20, expected=110) [fails] -> Buy_a(X, 10, expected=100) [succeeds] -> Sell_a(X, 10, expected=130) [fails]
balance(v) = original
balance(a) = original
```
That's the normal market dynamic? => not part of the paper definition, as in the `[fails]` case, it's not a >= for the price for all types (ether, tokens).


Frontrunning (at least Displacement) is the act of using tx information to create new transactions and make profit out of it. If a tool could automatically create an attack, would it skip the act of using tx information? If it can solve a puzzle contract without any additional input, it's a puzzle solver, not a frontrunning detector? Or both? And if it only solves it for a specific self-created instance of this puzzle (eg secret = keccak256(1234)), what about this? In displacement, the original tx doesn't even need to occur, so I don't think symbolic execution approaches would consider this. 

### Other stuff

Check top profit transaction in relation to https://arxiv.org/pdf/2212.12110.pdf ("'RM: Duplicate request'")