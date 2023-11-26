> Since changing the order between the client transaction and attacker transaction affect the final outcome of the latter, this means that the client transaction outcome is dependent on a state variable that the attacker transaction modifies.
> Automated Auditing of Ponzi Scheme Smart Contract TOD Vulnerabilities , 2017, p. 2

What exactly can these "state variable" be in reality? Go back to the Ethereum model and check on what a transaction can depend on (state, balances, block-environment, etc?). I think only relying on contract state misses a lot, at least in theory.