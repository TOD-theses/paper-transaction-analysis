## Main concept
Analyze if a function that sends Ether or Tokens to `recipient` does not verify `recipient`.

So there are three requirements:

1. A call to a payout function
2. No checks on the recipient
3. Value is > 0

This algorithm mainly covers (1) and (2).

## Base algorithm
```
def is_vulnerable(func):
	recipients = get_payout_recipients(func)
	for recipient in recipients:
		if not is_checked(func, recipient):
			return True
	return False

def get_payout_recipients(func):
	# iterate through statements (recursively?)
	# for each ether or token transfer
	# return the recipients

def is_checked(func, variable):
	# Return True when the function (or a sub-function) makes some check with the variable or something that depends on the variable
	for f in all_called_functions(func):
		for statement in statements(f):
			for value in get_checked_values(statement):
				if depends_on(value, variable):
					return True
	return False

def all_called_functions(func):
	# Return a list of all functions that could be called by func
	# Recurses into sub-functions

def get_checked_values(statement):
	# for require and assert, return all compared values
	# for If-statements, return all compared values
	# for signature verifications, return the signed content
	# for mapping acessess, return the used key (eg data[msg.sender] "checks" msg.sender)
	# ...
```

## Limitations

The algorithm considers a `require(msg.sender == msg.sender)` safe, as it does not evaluate the cheks.

## Potential Improvements

- verify if the transferred value depends on recipient (eg `msg.sender.transfer(balances[msg.sender])` is likely not vulnerable while `msg.sender.transfer(1000)` probably is) - inspired by the other TOD slither paper
- check if the value is arbitrary (eg input parameter)