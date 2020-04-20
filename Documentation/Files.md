# Files

[DESC]

[USE CASE]

[💾 <sub>Source Code</sub>](../Includes/Files.pbi)


## Remarks

Might be incompatible with older versions of PureBasic (<5.70) since some constants used in this include were added in that version.
Might just have to check.

## Procedures

`NormalizePath(Path$).s`
&emsp;Returns the given path `Path$` in a normalized way.
&emsp;This procedure will fix slashes depending on your platform, and [sheit].

`CreateDirectoryTree(OutputPath$).b`
&emsp;Returns non-zero if the given path `OutputPath$` [was built/created properly].

## Notes

???
