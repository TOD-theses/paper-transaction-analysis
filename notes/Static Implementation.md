## Slither Implementation
The hard part is `is_checked`. It is probably related to `is_protected`, but it only checks if the function checks `msg.sender` (eg `require(msg.sender == owner)`).

The `all_called_functions` can likely use the CFG from Slither.