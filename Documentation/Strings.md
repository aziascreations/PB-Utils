# Strings

This includes provides you with a couple of procedures [...]

[use cases]

[💾 <sub>Source Code</sub>](../Includes/Strings.pbi)


## Remarks

No constants or enumeration identifiers were used in this include.


## Procedures

`SplitArrayToString(Array A$(1), StringToSplit$, Delimeter$, CleanString.b=#True).q`<br>
&emsp;Returns the number of distinct entries in the given Array A$() and populates it with each part. [WTF !!!!!]<br>
&emsp;`Delimeter$` is the separator used between each entry in `InputString$`.<br>
&emsp;`CleanString.b` indicates to the procedure if it should clear any leading, trailing or inline empty entry before splitting the string.

`IsNullOrEmpty(A$).b`<br>
&emsp;Returns nonzero if `A$` is equal to `#Null$` or is filled with spaces.

`CommonPrefix(A$, B$).s`<br>
&emsp;Returns the largest common prefix in the given `A$` and `B$` strings.

`CommonPrefixLength(A$, B$).q`<br>
&emsp;Returns the length of the largest common prefix in the given `A$` and `B$` strings.


## Example

How to use `ExplodeStringToArray(...)`:
```
Define Dim Letters.s(0)
Define InputString = ";a;;b;c;;;;d;"

SplitArrayToString(Letters(), InputString, ";", #True)

; The returned value would be 4 since any empty part is cleaned.
; If we had set CleanString to #False, it would have returned a value of 10.
```
