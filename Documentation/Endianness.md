# Endianness

This includes provides you with a set of procedures that allow you to easily swap the endianness and nibbles of all the basic types in PureBasic.

It also uses ASM instructions directly to avoid wasting cycles doing arithmetic shifts.

[💾 <sub>Source Code</sub>](../Includes/Endianness.pbi)


## Remarks

All the procedures in this include use ASM instructions which could cause problems if you use the same registers.

The registers used are the `rax` family in every procedure, and the `rdx` family in `EndianSwapQ()`.


There are separate procedures made for the `.u` and `.a` types to avoid any potential problem that could happen if you use "EndianSwapW" when declaring an implicitely typed variable.


And no constants or enumeration identifiers were used in this include.

## Macro

`+EndianSwap(Number)`<br>
&emsp;Gets replaced by the appropriate corresponding procedure by the compiler.


## Procedures

### 1 byte

`NibbleSwapB(Number.b).b`<br>
&emsp;Returns the `byte` number given as `Number.b` with it's nibbles swapped.

`NibbleSwapA(Number.a).a`<br>
&emsp;Returns the `ascii` number given as `Number.a` with it's nibbles swapped.


### 2 bytes

`EndianSwapW(Number.w).w`<br>
&emsp;Returns the `word` number given as `Number.w` with it's endianness swapped.

`EndianSwapU(Number.u).u`<br>
&emsp;Returns the `unicode` number given as `Number.u` with it's endianness swapped.


### 4 bytes

`EndianSwapL(Number.l).l`<br>
&emsp;Returns the `long` number given as `Number.l` with it's endianness swapped.


### 4/8 bytes

<sup>*The byte length of the number will be affected by the architecture for which your program is compiled against.*</sup><br>
`EndianSwapI(Number.i).i`<br>
&emsp;Returns the `integer` number given as `Number.i` with it's endianness swapped.<br>


### 8 bytes

<sup>*The ASM instructions will vary depending on the architecture for which your program is compiled for, but the end result will stay the same.*</sup><br>
`EndianSwapQ(Number.q).q`<br>
&emsp;Returns the `quad` number given as `Number.q` with it's endianness swapped.


## Notes

A version of `EndianSwapQ()` that uses the SSE2 instruction set is available in the `Experiments/` folder as `EndianSwapQ_SSE.pbi`.

This include provides you with the procedure `EndianSwapQSSE(Number.q).q` which uses the `xmm0` and `xmm1` registers from the SSE2 instruction set.

It is a little bit slower than the one in the main include, taking ~210ms for a million swaps where the original x64 procedure takes ~185ms for the same amount of calls.

Please keep in mind that it is also your responsability to check if the SSE2 instruction set is supported on the CPU your program is ran on.
