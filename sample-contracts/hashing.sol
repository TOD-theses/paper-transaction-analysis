pragma solidity ^0.8.19;

contract Vulnerable {
    function withdraw(memory bytes input) {
        if (keccak256(input) == "0x12345678") {
            msg.sender.send(address(this).balance);
        }
    }
}


/*
Labels:
[ether]
[cfg-changes]
[keccak256]

Attack:

Contract Vulnerable is created with some balance.

T_A -> T_V
Attacker calls vulnerable.withdraw("preimage")
Victim calls vulnerable.withdraw("preimage")

Result: Attacker gains all the ether

T_A -> T_V
Victim calls vulnerable.withdraw("preimage")
Attacker calls vulnerable.withdraw("preimage")

Result: Victim gains all the ether
*/