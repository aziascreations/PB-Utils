# Purebasic Utils
A small collection of utils to help you develop stuff.<br>
TODO: Find a better intro/description.

## [Logger](SimpleLogger.pb) (Simple)
[UNFINISHED README]<br>
<br>

## [Strings](Strings.pb)
The [util] gives you access to the following procedures:<br>

```ExplodeStringToArray(Array a$(1), s$, d$)```<br>
&nbsp;&nbsp;&nbsp;&nbsp;Explodes a given String(s$) at every given delimiter(d$) and stores the String parts in a given pre-initialized Array(a$).<br>
&nbsp;&nbsp;&nbsp;&nbsp;Returns ???

```IsNullOrEmpty(a$)```<br>
&nbsp;&nbsp;&nbsp;&nbsp;Returns a nonzero value if a$ is equal to #Null$ or is filled with spaces.

## [Unit Testing](UnitTest-Basic.pb) (Basic)
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
&nbsp;&nbsp;&nbsp;&nbsp;"Passed" if `TestName.s` is empty or "Passed -> TestName.s" otherwise.

## [UUID4](UUID4.pb) ([Lite version](UUID4-Lite.pb))
In both version, you can generate a UUID4 by using the following procedure:

```GenerateUUID4()```<br>
&nbsp;&nbsp;&nbsp;&nbsp;Returns a UUID4 String that matches the standard.<br>

And if you use the [Full version](UUID4.pb), you have access to a regex (`#REGEX_ID_UUID4`) that lets you check if a String matches the UUID4 standard.<br>

# Enumerations Used
* Regex ID -> Regex
* Exit Codes -> ErrorCode (Used with `End [Integer]`)

# License
[???](LICENSE)
