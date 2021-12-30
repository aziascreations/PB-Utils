# PureBasic Utils
A collection of small includes that attempt to fix and give out access to
feature that are not present in PureBasic by default.

The documentation for each include is included in the source code itself,
as well as on a dedicated page that is accessible with a link given in
this readme and in the source code itself.

**The changelog can be found [here](changelog.md).**

## Summary
&emsp;● [Includes & Modules](#includes)<br>
&emsp;&emsp;⚬ [BasicTernary](#basicternary)<br>
&emsp;&emsp;⚬ [Colors](#colors)<br>
&emsp;&emsp;⚬ [Endianness](#endianness)<br>
&emsp;&emsp;⚬ [Strings](#strings)<br>
&emsp;&emsp;⚬ [UnitTest](#unittest)<br>
&emsp;&emsp;⚬ [UUID4](#uuid4)<br>
&emsp;● [Remarks](#remarks)<br>
&emsp;● [Credits](#credits)<br>
&emsp;● [License](#license)

## Includes & Modules

### BasicTernary
Contains a set of procedures that act as a sort of ternary operator for each
of the basic data types provided by PureBasic.

[📜 <sub>Documentation</sub>](Documentation/BasicTernary.md)&emsp;
[💾 <sub>Include</sub>](Includes/BasicTernary.pbi)&emsp;
[🧱 <sub>Module</sub>](Modules/BasicTernary.pbi)

### Colors
Contains a collection of RGB color constants from CSS3 and Windows Metro UI.

[📜 <sub>Documentation</sub>](Documentation/Colors.md)&emsp;
[💾 <sub>Include</sub>](Includes/Colors.pbi)&emsp;
[🧱 <sub>Module</sub>](Modules/Colors.pbi)

### Endianness
Contains a set of procedures and a macro that will swap the endianness or
nibbles of a given value which has one of the basic types provided by PureBasic.

The primary use for this include is to be able to interact with binary data
without having to worry about implementing a new way of swapping endianness
each time.

[📜 <sub>Documentation</sub>](Documentation/Endianness.md)&emsp;
[💾 <sub>Include</sub>](Includes/Endianness.pbi)&emsp;
[🧱 <sub>Module</sub>](Modules/Endianness.pbi)

### Strings
Contains a set of procedures to manipulate string more easily in some cases
that aren't directly supported by PureBasic.

The included procedures allow you to split a string, check if it is null or empty
or detect common prefixes.

[📜 <sub>Documentation</sub>](Documentation/Strings.md)&emsp;
[💾 <sub>Include</sub>](Includes/Strings.pbi)<br><br>

### UnitTest
???

[📜 <sub>Documentation</sub>](Documentation/UnitTest.md)&emsp;
[💾 <sub>Include</sub>](Includes/UnitTest.pbi)<br><br>

### UUID4
Contains a set of procedures to generate UUID4 strings and to validate them.

A procedure to generate it directly into a buffer is also planned.

[📜 <sub>Documentation</sub>](Documentation/UUID4.md)&emsp;
[💾 <sub>Include</sub>](Includes/UUID4.pbi)<br><br>

## Remarks
Some includes may declare constants and use some enumeration identifiers.<br>
More information about these can be found on the respective documentation page of each include.

## Credits
● Demivec<br>
&emsp;&emsp; ⚬ Strings - Original `ExplodeStringToArray(...)` procedure idea
&emsp;([Thread](http://www.purebasic.fr/english/viewtopic.php?f=13&t=41704))<br>

● djes<br>
&emsp;&emsp; ⚬ Endianness - Original `EndianSwapL(Number.l)` procedure idea
&emsp;([Thread](https://www.purebasic.fr/english/viewtopic.php?f=19&t=17427))

## License
This license applies to all the code in this repo.

[Unlicensed](LICENSE)
