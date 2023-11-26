https://swcregistry.io/docs/SWC-114/

https://github.com/trailofbits/manticore/
https://github.com/nveloso/conkas

ERC 20 attack can be done in reverse direction (someone wants to spend the money, I disapprove the moment before they do => until they want to use the money, they think I gave it to them)

The paper only detects cases where a different order results in a different state, not necessarily frontrunning attacks. It does not know whether these were on purpose. And are there cases, where this difference in state does not give an advantage to the attacker? Probably.

## Formal definition (attempts)

Front running occurs, when an attacker gains a benefit by using the information that someone wants to perform a transaction to create another transaction that will be mined first.

Formal modeling:

```
Benefit(Attacker) == X for: Tx(User) -> Tx(Attacker) -> ...
Benefit(Attacker) >  X for: Tx(Attacker) -> Tx(User) -> [Tx(Attacker)]
```

Note that in the second case, the attacker already knows how `Tx(User)` looks like, so `Tx(Attacker) = create_front_running_transaction(global_state, Tx(User))`. 


In the ERC 20 case, how would this model work?

given global state: User allows spending of 20 ETH

```
balance(Attacker) == 20 for: Tx(by=User, what=approve(Attacker, n0)) -> Tx(by=Attacker, what=receive(10))
balance(Attacker) >  20 for: Tx(by=Attacker, what=receive(20) -> Tx(by=User, what=approve(Attacker, 10)) -> Tx(by=Attacker, what=receive(10))
```

In this case, the front running transaction does not *need* the information from the users one. Thus it could also happen "by accident" that it is done in this order.

In other cases, the front running transaction would rely on the information from the users one (solution to a math problem / more contrived examples where the user sends money to an address stored in the contract).

This should be made as a distinction I guess.

## Prevention

The TOD occurs, because previous transactions modify the state and thus modify the outcome¹. If the user makes a transaction that puts all the wanted (expected == current) state into a require, it will either succeed or simply fail. While arguably this is still TOD (we changed the outcome to a fail by frontrunning the transaction), the bad outcome is migitated (the user does not take an action with the modified state).

This would suggest a TOD definition similar to:
- No matter the other (inserted) transactions, if a user makes a transaction it either succeeds the same way it would without any other transactions, or it fails without a state change.

Is a solution, such as for proposed by the Ponzi scheme, even practical? If we always put the expected value, when two transactions in the same block by the same token, the latter one will always fail, even without malicious intentions.

This would take into account fixes like for ERC (which add an additional argument for the expected current value and then `require(currentStateValue == expectedValue)`). Would it miss vulnerabilities? Is forcing a user to a failed transaction a vulnerability? Would there be a benefit of an attacker?

This would not cover vulnerabilities for last-transaction-wins contracts and first-one-who-solves-this-puzzle-wins contracts.


[1] Inspired by Automated Auditing of Ponzi Scheme Smart Contract TOD Vulnerabilities