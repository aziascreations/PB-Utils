# PureBasic - Utils
A collection of small includes that attempt to fix and give out access to features that are not present in PureBasic by default.

The documentation for each include is included in the source code itself, as well as on a dedicated page that is accessible with a link given in this readme and in the source code itself.

If you want to consult the changelog, you can do so [here](changelog.md).

> [!WARNING]
> This repository is archived, and development has been split in these repositories:
> * [PB-Endianness](https://github.com/aziascreations/PB-Endianness/)
> * *More to come in the future...*


## Summary
* [Includes](#includes)
  * [BasicTernary](#basicternary)
  * [Colors](#colors)
  * [Endianness](#endianness)
  * [Files](#files)
  * [Strings](#strings)
  * [UUID4](#uuid4)
* [Remarks](#remarks)
* [Credits](#credits)
* [License](#license)


## Includes

### BasicTernary
Contains a set of procedures that act as a sort of ternary operator for each of the basic data types provided by PureBasic.

* [📜 Docs](Documentation/BasicTernary.md)
* [💾 Sources](Includes/BasicTernary.pbi)


### Colors
Contains a collection of RGB color constants that are from CSS3, or Windows Metro UI.

* [📜 Docs](Documentation/Colors.md)
* [💾 Sources](Includes/Colors.pbi)



### Endianness
Contains a set of procedures and a macro that will swap the endianness or nibbles of a given value which has one of the basic types provided by PureBasic.

The primary use for this include is to be able to interact with binary data without having to worry about implementing a new way of swapping endianness each time.

* [📜 Docs](Documentation/Endianness.md)
* [💾 Sources](Includes/Endianness.pbi)


### Files
~~**Comming soon**~~

Contains a small set of procedures to help with files and paths.

* [📜 Docs](Documentation/Files.md)
* [💾 Sources](Includes/Files.pbi)


### Strings
Contains a set of procedures to manipulate string more easily if you need to. \
The included procedures allow you to split a string and check if it is null or empty.

* [📜 Docs](Documentation/Strings.md)
* [💾 Sources](Includes/Strings.pbi)


### UUID4
Contains a set of procedures to generate UUID4 strings and to validate them. \
A procedure to generate it directly into a buffer is also planned.

* [📜 Docs](Documentation/UUID4.md)
* [💾 Sources](Includes/UUID4.pbi)


## Remarks
Some of the includes may declare constants and use some enumeration identifiers.<br>
More information about these can be found on the respective documentation page of each include.


## Credits
* Demivec
  * Strings - Original `ExplodeStringToArray(...)`
    ([Thread](http://www.purebasic.fr/english/viewtopic.php?f=13&t=41704))
* djes
  * Endianness - Original `EndianSwapL(Number.l)`
    ([Thread](https://www.purebasic.fr/english/viewtopic.php?f=19&t=17427))


## License
All the code in this repo is released in the [Public Domain](LICENSE).
