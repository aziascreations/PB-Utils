# Purebasic Utils
A small collection of utilities designed to help you in [programming in PB ?].<br>

**Disclaimer:**<br>
Some procedure are based on [other people's code] .<br>
For each of them, credit is given to the original author and a [source url] is also given.

**Available utilities:**<br>
&nbsp;&nbsp;● [Logger](#logger)<br>
&nbsp;&nbsp;● [Strings](#strings)<br>
&nbsp;&nbsp;● [Unit Testing](#unit-testing-basic)<br>
&nbsp;&nbsp;● [UUID4](#uuid4-lite-version)

## Utilities
### [Logger](SimpleLogger.pb)
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

TODO: Replace Title.s by MBTitle.s

#### ◆ **Usage**
<br>

### [Strings](Strings.pb)
This utility gives you access to the following procedures:<br>

`ExplodeStringToArray(Array a$(1), s$, d$)`<br>
&nbsp;&nbsp;&nbsp;&nbsp;Explodes a given String(s$) at every given delimiter(d$) and stores the String parts in a given pre-initialized Array(a$).<br>
&nbsp;&nbsp;&nbsp;&nbsp;Returns ???

`IsNullOrEmpty(a$)`<br>
&nbsp;&nbsp;&nbsp;&nbsp;Returns a nonzero value if a$ is equal to #Null$ or is filled with spaces.<br>
<br>

### [Unit Testing](UnitTest-Basic.pb) (Basic)
This basic unit testing util gives you access to the followinf procedures and value:

`AssertTrue(Bool.b, TestName.s="")`<br>
&nbsp;&nbsp;&nbsp;&nbsp;If `Bool.b` is true, the value of `PassedTests.i` will be incremented, otherwise, `FailedTests.i` will be.<br>
&nbsp;&nbsp;&nbsp;&nbsp;A condition can be passed as `Bool.b` if it is "wrapped" in a `Bool()` procedure.

`Assert(Bool.b, TestName.s="")`<br>
&nbsp;&nbsp;&nbsp;&nbsp;Same as `AssertTrue()`.

`AssertFalse(Bool.b, TestName.s="")`<br>
&nbsp;&nbsp;&nbsp;&nbsp;The opposite of `AssertTrue()`.

`Pass(TestName.s="")`<br>
&nbsp;&nbsp;&nbsp;&nbsp;Will simple increment `PassedTests.i` and print "Passed" in the debug window

`Fail(TestName.s="")`<br>
&nbsp;&nbsp;&nbsp;&nbsp;Will simple increment `FailedTests.i` and print "Failed" in the debug window

`PassedTests.i`: The number of passed tests<br>
`FailedTests.i`: The number of failed tests

The `TestName.s` parameter is optional and will simply influence the text displayed in the debug window.<br>
&nbsp;&nbsp;&nbsp;&nbsp;"Passed" if `TestName.s` is empty or "Passed -> TestName.s" otherwise.<br>
<br>

### [UUID4](UUID4.pb) ([Lite version](UUID4-Lite.pb))
In both version, you can generate a UUID4 by using the following procedure:

```GenerateUUID4()```<br>
&nbsp;&nbsp;&nbsp;&nbsp;Returns a UUID4 String that matches the standard.<br>

And if you use the [Full version](UUID4.pb), you have access to a regex (`#REGEX_ID_UUID4`) that lets you check if a String matches the UUID4 standard.<br>

# [Enumerations Used]
* Regex ID -> Regex
* Exit Codes -> ErrorCode (Used with `End [Integer]`)

# Credits
The original authors and posts are also mentionned and linked in the source files.

● Demivec<br>
&nbsp;&nbsp;&nbsp;&nbsp; ⚬ Strings - `ExplodeStringToArray(...)`
&nbsp;&nbsp;([Thread](http://www.purebasic.fr/english/viewtopic.php?f=13&t=41704))<br>

● Mistrel<br>
&nbsp;&nbsp;&nbsp;&nbsp; ⚬ UUID4 - Original GUID generator
&nbsp;&nbsp;([Thread](http://www.purebasic.fr/english/viewtopic.php?t=38008))

# License
[I still don't know...](LICENSE)
