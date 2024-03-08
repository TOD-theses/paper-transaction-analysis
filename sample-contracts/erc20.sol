pragma solidity ^0.8.19;

contract Vulnerable {
    ERC20 token;

    function withdraw() {
        token.transfer(msg.sender, token.balanceOf(address(this)));
    }
}

contract ERC20 {
    function totalSupply() {
        return 1234;
    }

    function balanceOf(address _owner) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 value) {
        balances[msg.sender] -= value;
        balances[_to] += value;
        emit Transfer(msg.sender, _to, _value);
    }

    function transferFrom(address _from, address _to, uint256 value) {
        require(allowance[_from][msg.sender] >= value);
        allowance[_from][msg.sender] -= value;
        balances[_from] -= value;
        balances[_to] += value;
        emit Transfer(_from, _to, _value);
    }

    function approve(address _spender, uint256 _value) {
        // prevent frontrunning
        require(_value == 0 || allowances[_msg.sender][spender] == 0);
        allowances[_msg.sender][_spender] = _value;
        emit Approval(_msg.sender, _spender, _value);
    }

    function allowance(address _owner, address _spender) {
        return allowances[_owner][_spender];
    }
}


/*
Labels:
[erc20]
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