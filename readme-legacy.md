# Purebasic Utils
This repository contains a small collection of utilities designed to help you with specific tasks in PureBasic.

# This readme is out of date, please read the source code for the doc in the comments.

This repo is mostly a collection of small procdeures that can help in projects.


# Purebasic Utils
A small collection of utilities designed to help you in [programming in PB ?].<br>

**Disclaimer:**<br>
Some procedures are based on other people's code.<br>
For each of them, credit is given in the source code files and in the [Credits](#credits) section.<br>
And a url linking to the original thread or post is also given.


Every source code should work with EnableExplicit.

**Available utilities:**<br>
&nbsp;&nbsp;● [Logger](#logger)<br>
&nbsp;&nbsp;● [Semantic Versioning](#semantic-versioning)<br>
&nbsp;&nbsp;● [Strings](#strings)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;⚬ [ExplodeStringToArray()](#user-content-strings.explodestringtoarray)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;⚬ [IsNullOrEmpty()](#user-content-strings.isnullorempty)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;⚬ [Format()](#user-content-strings.format)<br>
&nbsp;&nbsp;● [Unit Testing](#unit-testing-basic)<br>
&nbsp;&nbsp;● [UUID4](#uuid4-logger-version--lite-version)

## Utilities
### [Logger](Logger.pb)

<a name="logger.tmp"></a>
<details>
<summary><code>Click to expand</code></summary>
<b>!!! A large portion of the formatter will be reworked when the Strings.Format() procedure is finished. !!!</b>

This utility lets you easily log things to the console, debug window, or to a log file.

#### ◆ **Log file configuration**
`ConfigureLoggerOutputPath(LogFilePath.s="", KeepPreviousIfError.b=#True)`<br>
[*]An empty string will disable the log file and ...

#### ◆ **Logging levels configuration**
`ConfigureLogLevels(LogFileLoggingLevel.b=..., DebugWindowLoggingLevel.b=..., ConsoleLoggingLevel.b=...)`<br>

These 3 procedures allow you to configure each level independently:<br>
&nbsp;&nbsp;&nbsp;&nbsp;`ConfigureFileLogLevel(LogFileLoggingLevel.b)`<br>
&nbsp;&nbsp;&nbsp;&nbsp;`ConfigureDebugWindowLogLevel(DebugWindowLoggingLevel.b)`<br>
&nbsp;&nbsp;&nbsp;&nbsp;`ConfigureConsoleLogLevel(ConsoleLoggingLevel.b)`<br>

Available logging levels:<br>
&nbsp;&nbsp;&nbsp;&nbsp;`#LoggingLevel_Trace` - "Super-debug" level<br>
&nbsp;&nbsp;&nbsp;&nbsp;`#LoggingLevel_Debug` - <br>
&nbsp;&nbsp;&nbsp;&nbsp;`#LoggingLevel_Fatal` - <br>
&nbsp;&nbsp;&nbsp;&nbsp;`#LoggingLevel_Error` - <br>
&nbsp;&nbsp;&nbsp;&nbsp;`#LoggingLevel_Warn` - <br>
&nbsp;&nbsp;&nbsp;&nbsp;`#LoggingLevel_Info` - <br>
&nbsp;&nbsp;&nbsp;&nbsp;`#LoggingLevel_Off` - <br>
&nbsp;&nbsp;&nbsp;&nbsp;`#LoggingLevel_Any` - Everything except the Trave level.<br>
&nbsp;&nbsp;&nbsp;&nbsp;`#LoggingLevel_Keep` - Only used internally or with `ConfigureLogFormats(...)`.

#### ◆ **Logging formats configuration**

`ConfigureLogFormats(TimeFormat.s="", DebugWindowLoggingFormat.s="", LogFileLoggingFormat.s="", ConsoleLoggingFormat.s="")`<br>
This procedure will 

These 4 procedure allow you to configure each format independently:<br>
&nbsp;&nbsp;&nbsp;&nbsp;`ConfigureTimeLogFormat(TimeFormat.s)`<br>
&nbsp;&nbsp;&nbsp;&nbsp;`ConfigureDebugWindowLogFormat(DebugWindowLoggingFormat.s)`<br>
&nbsp;&nbsp;&nbsp;&nbsp;`ConfigureFileLogFormat(LogFileLoggingFormat.s)`<br>
&nbsp;&nbsp;&nbsp;&nbsp;`ConfigureConsoleLogFormat(ConsoleLoggingFormat.s)`

The following [?] can be used in the format String:<br>
&nbsp;&nbsp;&nbsp;&nbsp;● `%time%` will be replaced by the formatted time (`TimeFormat.s`).<br>
&nbsp;&nbsp;&nbsp;&nbsp;● `%msg%` will be replaced by the message (`Message.s`).<br>
&nbsp;&nbsp;&nbsp;&nbsp;● `%mbtitle%` will be replaced by the MessageBox title (`MBTitle.s`).<br>
&nbsp;&nbsp;&nbsp;&nbsp;● `%mbmsg%` will be replaced by the MessageBox message (`MBMessage.s`).<br>

Default formats:<br>
&nbsp;&nbsp;&nbsp;&nbsp;● File: `"%time% - %msg%"`<br>
&nbsp;&nbsp;&nbsp;&nbsp;● Time: `"%yy-%mm-%dd %hh:%ii:%ss"`<br>
&nbsp;&nbsp;&nbsp;&nbsp;● Debug: `"%msg%"`<br>
&nbsp;&nbsp;&nbsp;&nbsp;● Console: `"%msg%"`

#### ◆ **Usage**
<br>
</details><br>


### [Semantic Versioning](SemanticVersioning.pb)

<code>InitializeSemVer(CanShowMessages.b=#False, CanEndProgram.b=#True)</code><br>

<code>IsVersionValid(Version.s, DoValidityCheck=#True)</code><br>

<code>GetVersionNumber(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)</code><br>

<code>GetVersionMajor(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)</code><br>

<code>GetVersionMinor(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)</code><br>

<code>GetVersionPatch(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)</code><br>

<code>IsVersionCompatible(VersionA.s, VersionB.s)</code>

<br>


### [Strings](Strings.pb)

<a name="strings.explodestringtoarray"></a>
<details>
<summary><code>ExplodeStringToArray(Array a$(1), s$, d$)</code></summary>
<p>&nbsp;&nbsp;<b>How it works:</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;Explodes a given String(s$) at every given delimiter(d$) and stores the String parts in a given pre-initialized Array(a$).</p>

<p>&nbsp;&nbsp;<b>Returns :</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;The number of occurences/sections in the given String.</p>
&nbsp;&nbsp;&nbsp;&nbsp;Or the amount of entries in the array.</p>
</details><br>

<a name="strings.isnullorempty"></a>
<details>
	<summary><code>IsNullOrEmpty(a$)</code></summary>
<p>&nbsp;&nbsp;<b>Parameters:</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;a$ - A String that will be analysed.</p>

<p>&nbsp;&nbsp;<b>Returns :</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;A nonzero value if <i>a$</i> is equal to <i>#Null$</i>, of length 0 or if it is filled with spaces characters (0x20).</p>
</details><br>

<a name="strings.format"></a>
<details>
<summary><code>Format(text.s, *val1=0, ..., *val11=0)</code></summary>
<b>TEMP: This function isn't finished!</b>

<p>&nbsp;&nbsp;<b>How it works:</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;???</p>

<p>&nbsp;&nbsp;<b>Parameters:</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;text.s - ???<br>
&nbsp;&nbsp;&nbsp;&nbsp;*val1 - ???<br>
&nbsp;&nbsp;&nbsp;&nbsp;*val11 - ???<br></p>

<p>&nbsp;&nbsp;<b>Formatting:</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;???</p>

<p>&nbsp;&nbsp;<b>Returns:</b><br>
&nbsp;&nbsp;&nbsp;&nbsp;The formatted String</p>
</details><br>

<br>


### [Unit Testing](UnitTest-Basic.pb) (Basic)
This basic unit testing [module ???] utility gives you access to the following procedures and values:

<b>Procedures:</b><br>
`Assert(Bool.b, TestName.s="")`<br>
&nbsp;&nbsp;&nbsp;&nbsp;If `Bool.b` is true, the value of `PassedTests.i` will be incremented, otherwise, `FailedTests.i` will be.<br>
&nbsp;&nbsp;&nbsp;&nbsp;A condition can be passed as `Bool.b` if it is "wrapped" in a `Bool()` procedure.

`AssertTrue(Bool.b=#True, TestName.s="")`<br>
&nbsp;&nbsp;&nbsp;&nbsp;Same as `Assert()`, with a default value for `Bool.b`.

`AssertFalse(Bool.b=#False, TestName.s="")`<br>
&nbsp;&nbsp;&nbsp;&nbsp;The opposite of `AssertTrue()`.

`Pass(TestName.s="")`<br>
&nbsp;&nbsp;&nbsp;&nbsp;Will simply increment `PassedTests.i` and print "Passed" in the debug window

`Fail(TestName.s="")`<br>
&nbsp;&nbsp;&nbsp;&nbsp;Will simply increment `FailedTests.i` and print "Failed" in the debug window

<b>Global Variables:</b><br>
`PassedUnitTests.i`: The number of passed tests<br>
`FailedUnitTests.i`: The number of failed tests

<b>Remarks:</b><br>
The `TestName.s` parameter is optional and will simply influence the text displayed in the debug window.<br>
&nbsp;&nbsp;&nbsp;&nbsp;"Passed" if `TestName.s` is empty or "Passed -> TestName.s" otherwise.<br>
<br>

### [UUID4](UUID4.pb) ([Logger version](UUID4-Logger.pb))
In both version, you can generate a UUID4 by using the following procedure:

``GenerateUUID4()``<br>
&nbsp;&nbsp;&nbsp;&nbsp;Returns a UUID4 String that matches the standard.<br>

``IsUUID4Compliant(uuid4$)``<br>
&nbsp;&nbsp;&nbsp;&nbsp;Returns a non-zero value if the string matches the regex.<br>

You also have access to a regex (`#REGEX_ID_UUID4`) that lets you check if a String matches the UUID4 standard.<br>

# Enumerations Used
* Regex (Used for regex IDs)
* ErrorCode (Used with `End [Integer]`)

# Usefull Links
* [cli-args-pb](https://github.com/aziascreations/cli-args-pb): Launch parameters parser

# Credits
The original authors and posts are also mentionned and linked in the source files.

● Demivec<br>
&nbsp;&nbsp;&nbsp;&nbsp; ⚬ Strings - `ExplodeStringToArray(...)`
&nbsp;&nbsp;([Thread](http://www.purebasic.fr/english/viewtopic.php?f=13&t=41704))<br>

● Mistrel<br>
&nbsp;&nbsp;&nbsp;&nbsp; ⚬ UUID4 - Original GUID generator
&nbsp;&nbsp;([Thread](http://www.purebasic.fr/english/viewtopic.php?t=38008))

# License
[WTFPL](LICENSE)
