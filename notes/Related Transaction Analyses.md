
# Frontrunner Jones

## Definitions

Displacement: 
"The general idea is to detect displacement by checking for every transaction T if there exists a subsequent transaction T ′ with a gas price lower than T and a transaction index higher than T , where the input of T ′ is contained inside the input of T"
Uses replays for TOD detection, claims TOD if count(steps) differs for the traces.

Insertion:
Analyzes transfer events Event_recv_A -> Event_recv_V -> Event_send_A

Suppression:
Not TOD relevant (I'd consider it a timestamp issue)

## Scale
11M blocks with 100-block windows.
3000 displacement attacks
200.000 insertion attacks
## Shortcomings

Heuristics limit much (eg an attacker does not need higher gas if they are the miner, inputs don't need to match, attackers don't need bot contracts, etc.).

Insertion requires a selling directly after the attack (that's likely?), in the same block!
## Useful ideas

Miner address should be != 0 (some bots apparently check for this).
Automated TOD bots likely copy the input => at some point in the call tree they should make an equal call.

# Combatting Front-Running in Smart Contracts

## Definitions

2+ transactions where T_A -> T_V -> T_Ap and T_V -> T_A -> T_Ap have following properties:
"Property 1 (Attacker Gain): The attacker obtains financial gain in the attack scenario compared with the attack-free scenario."
"Property 2 (Victim Loss): The victim suffers from financial loss in the attack scenario compared with the attack-free scenario."

Financial gain/loss meaning ether or tokens.

Manual check: can the attacker make profit even without the victims transaction?
## Scale
800.000 blocks with 3-block windows.
200.000 attacks

## Useful ideas

Read-write conflicts (the attacker writes data that the victim reads)

Profit collection transaction: S. Eskandari, S. Moosavi, and J. Clark, “SoK: Transparent dishonesty: Front-running attacks on blockchain,” in Financial Cryptography and Data Security, ser. Lecture Notes in Computer Science, A. Bracciali, J. Clark, F. Pintore, P. B. Rønne, and M. Sala Eds., Cham, Berlin, Germany: Springer, 2019, pp. 170–189

### Vulnerability localization
For an attack: TOD source (attack altered data access) -> ... -> TOD sink (profits) / TOD path condition (control flow change)

They consider the flow from the altered data to the sink input as vulnerable (only the instructions that take part of this flow). They name it "influence trace".

They differ between 3 cases:
- Path Condition Alteration (my control flow change, except out of gas)
- Computation Alteration (my non-control flow change)
- Gas Estimation Griefing (out of gas)

They also consider multiple TOD sources and thus influence traces.

I can get close to this by checking changed instructions. Every instruction that is part of the influence trace is also a changed instruction (different inputs/outputs).

### Write-write conflicts

A TOD theoretically could also include write-write conflicts: If both transactions store a value at the same key, the value stored after both depends on their order. I guess we can ignore this case if it doesn't affect their execution?
The stored value is TOD, however if an attacker frontruns the victims transaction it doesn't modify the outcome, only if they post-run it.

### Benchmark construction
They take the most attacked contracts from influence traces, and also show that sampling more attacks would not yield significantly more vulnerable functions.