## Main concept
Create a dataset of all function that should not be called with arbitrary data.

## Sources
- standardized interfaces
- commonly used interfaces (eg check OpenZeppelin contracts)
- automated analysis (?)

## Data format

Should be useful for Solidity level and EVM level analysis.

```
Sink {
	functionSignature,
	functionName,
	parameters: [
		 {
		   type,
		   name,
		   isSink: true/false,
		   sinkConditions: [
				"non-zero"
		   ],
		   notes		 
		 }	
	],
	notes
}
```

## Questions
Should sinks consist only of one parameter, or can it be a combination of two+?