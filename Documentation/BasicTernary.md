# BasicTernary
This include provides you with a set of procedures that act as a sort of ternary operator that allow you to make some of you code more readable and reduce the amount of lines of code present in your files.

**Links:**<br>
&nbsp;&nbsp;[💾 <sub>Include</sub>](../Includes/BasicTernary.pbi)<br>
&nbsp;&nbsp;[🧱 <sub>Module</sub>](../Modules/BasicTernary.pbi)

## Remarks
Due to the fact that the procedures contained in this include aren't implemented as macros, their use in a big loop may potentially hinder performances due to the repeated subroutine jumps.

A macro would have had better performances, but it couldn't be implemented cleanly.

## Module
The module version of this include uses the `BasicTernary` name.

Some constants are also provided in order to help you check the version number of the module itself:
&nbsp;&nbsp;`#Version$`, `#Version_Major`, `#Version_Minor` and `#Version_Patch`

## Procedures
`IfA(Condition.b, TrueValue.a, FalseValue.a).a`

`IfB(Condition.b, TrueValue.b, FalseValue.b).b`

`IfC(Condition.b, TrueValue.c, FalseValue.c).c`

`IfD(Condition.b, TrueValue.d, FalseValue.d).d`

`IfF(Condition.b, TrueValue.f, FalseValue.f).f`

`IfI(Condition.b, TrueValue.i, FalseValue.i).i`

`IfL(Condition.b, TrueValue.l, FalseValue.l).l`

`IfP(Condition.b, *TrueValue, *FalseValue).*`

`IfQ(Condition.b, TrueValue.q, FalseValue.q).q`

`IfS(Condition.b, TrueValue.s, FalseValue.s).s`

`IfU(Condition.b, TrueValue.u, FalseValue.u).u`

`IfW(Condition.b, TrueValue.w, FalseValue.w).w`

&emsp;Each of these procedures will either return the given `TrueValue` or `FalseValue` depending on wether or not the boolean `Condition` is true or false.

&emsp;For the parameter `Condition.b`, you have to wrap your condition in a `Bool()` statement to make sure it is passed as a boolean.

## Example
This piece of code in PureBasic
```ruby
XincludeFile "BasicTernary.pbi"

x = 1 : y = 2 

Debug IfS(Bool(x > y), "X is bigger than Y", "X isn't bigger than Y")
```

Gives the same result as this one in java
```java
int x=1, y=2;

System.out.println((x > y ? "X is bigger than Y" : "X isn't bigger than Y"));
```
