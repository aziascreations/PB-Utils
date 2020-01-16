# PureBasic Utils

A collection of small includes that attempt to fix and give out access to features that are not present in PureBasic by default.

The documentation for each include is included in the source code itself, as well as on a dedicated page that is accessible with a link given in this readme and in the source code itself.

If you want to consult the changelog, you can do so [here](changelog.md).


## Summary

&emsp;● [Includes](#includes)<br>
&emsp;&emsp;⚬ [BasicTernary](#basicternary)<br>
&emsp;&emsp;⚬ [Colors](#colors)<br>
&emsp;&emsp;⚬ [Endianness](#endianness)<br>
&emsp;&emsp;⚬ [Files](#files)<br>
&emsp;&emsp;⚬ [Strings](#strings)<br>
&emsp;&emsp;⚬ [UUID4](#uuid4)<br>
&emsp;● [Remarks](#remarks)<br>
&emsp;● [Credits](#credits)<br>
&emsp;● [License](#license)<br>


## Includes

In this section you will find a list of all the includes, as well as a short description of it, and links to the documentation and the source code.


### BasicTernary

Contains a set of procedures that act as a sort of ternary operator.

[use case]

[📜 <sub>Documentation</sub>](Documentation/BasicTernary.md)&emsp;&emsp;
[💾 <sub>Source Code</sub>](Includes/BasicTernary.pbi)<br>
<br>


### Colors

Contains a collection of RGB color constants that are from CSS3, or Windows Metro UI.<br>
It also contains a couple of constants for different shades of gray.

[📜 <sub>Documentation</sub>](Documentation/Colors.md)&emsp;&emsp;
[💾 <sub>Source Code</sub>](Includes/Colors.pbi)<br>
<br>


### Endianness

Contains a set of procedures and a macro that will swap the endianness or nibbles of a given value which has one of the basic types provided by PureBasic.

The primary use for this include is to be able to interact with binary data without having to worry about [process of swapping] endianness.

[📜 <sub>Documentation</sub>](Documentation/Endianness.md)&emsp;&emsp;
[💾 <sub>Source Code</sub>](Includes/Endianness.pbi)&emsp;&emsp;<!--[📥 <sub>Releases</sub>](Includes/Endianness.pbi)--><br>
<br>


### Files

**Comming soon**

Contains a small set of procedures to help with files and paths.

[📜 <sub>Documentation</sub>](Documentation/Files.md)&emsp;&emsp;
[💾 <sub>Source Code</sub>](Includes/Files.pbi)<br>
<br>


### Strings

Contains a set of procedures to manipulate string more easily if you need to.

The included procedures allow you to split a string and check if it is null or empty.

[📜 <sub>Documentation</sub>](Documentation/Strings.md)&emsp;&emsp;
[💾 <sub>Source Code</sub>](Includes/Strings.pbi)<br>
<br>


### UUID4

Contains a set of procedures to generate UUID4 strings and to validate them.

A procedure to generate it directly into a buffer is also planned.

[📜 <sub>Documentation</sub>](Documentation/UUID4.md)&emsp;&emsp;
[💾 <sub>Source Code</sub>](Includes/UUID4.pbi)<br>
<br>


## Remarks

Some of the includes may declare constants and use some enumeration identifiers.<br>
More information about these can be found on the respective documentation page of each include.


## Credits

The original authors and posts are also mentioned and linked in the source files.

<!--[Have been rewritten and "improved" to avoid dealing with license issues]-->

● Demivec<br>
&emsp;&emsp; ⚬ Strings - Original `ExplodeStringToArray(...)` procedure
&emsp;([Thread](http://www.purebasic.fr/english/viewtopic.php?f=13&t=41704))<br>

● Mistrel<br>
&emsp;&emsp; ⚬ UUID4 - Original GUID generator
&emsp;([Thread](http://www.purebasic.fr/english/viewtopic.php?t=38008))

● djes<br>
&emsp;&emsp; ⚬ Endianness - Original `EndianSwapL(Number.l)` procedure
&emsp;([Thread](https://www.purebasic.fr/english/viewtopic.php?f=19&t=17427))


## License

This license applies to all the code in this repo, except for Demivec's `ExplodeStringToArray(...)` and Mistrel's UUID4 procedure which are gonna be rewritten in the next commit to avoid any license issue.

[WTFPL](LICENSE)

<!--
Write the uuid 4 directly in a string buffer (A$ = Space(n) with RandomData(...))
Trash
Note, use grip to view this readme locally.
 (📃📃 | 🧱🧱  💾 📜 🧾 📝)mod
[📜 Doc]()&#9;&#9;[💾 Include]()<br>
[📜 Doc]()&ensp;&ensp;[💾 Include]()<br>
[📜 <sub>Documentation</sub>]()&emsp;&emsp;[💾 <sub>Include</sub>]()-->
