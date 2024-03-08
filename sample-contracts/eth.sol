pragma solidity ^0.8.19;

contract Vulnerable {
    function withdraw() {
        msg.sender.send(address(this).balance);
    }
}


/*
Labels:
[ether]
[cfg-constant]

Attack:

Contract Vulnerable is created with some balance.

T_A -> T_V
Attacker calls vulnerable.withdraw()
Victim calls vulnerable.withdraw()

Result: Attacker gains all the ether

T_A -> T_V
Victim calls vulnerable.withdraw()
Attacker calls vulnerable.withdraw()

Result: Victim gains all the ether
*/