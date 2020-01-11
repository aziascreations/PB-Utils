# BasicTernary

This include provides you with a set of procedures that act as a sort of ternary operator that allow.

[It is mostly helpful to save on line count]

[💾 <sub>Source Code</sub>](../Includes/BasicTernary.pbi)


## Remarks

Due to the fact that the procedure listed below [need to be called as procedures], their use in a big loop may potentially hinder performances due to the fact [there is a fct/proc/routine called issued each and every time].

A macro could have had better performances if it had been rediced to a simple if/else condition, but it wouldn't have been as versatile as proper procedures.


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

&emsp;Each and everyone of these procedures will either return `TrueValue` or `FalseValue` depending on wether or not the boolean `Condition` is true or false.

&emsp;For the parameter `Condition.b`, you have to wrap your condition in a `Bool()` [call] to make sure it is passed as a boolean.


## Example

This piece of code in PureBasic

```ruby
XincludeFile "BasicTernary.pbi"

x = 1 : y = 2 

Debug IfS(Bool(x>y), "X is bigger than Y", "X isn't bigger than Y")
```

Gives the same result as this one in java
```java
int x=1, y=2;

System.out.println((x>y ? "X is bigger than Y" : "X isn't bigger than Y"));
```
