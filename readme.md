# Purebasic Utils
A small collection of utils to help you develop stuff.<br>
TODO: Find a better intro/description.

## [Logger](SimpleLogger.pb) (Simple)
[UNFINISHED README]<br>
<br>

## [Strings](Strings.pb)
The [util] gives you access to the following procedures:
```asm
; Explodes a given String (s$) at every given delimiter (d$) and stores the String parts in a given Array (a$).
; Returns: ???
ExplodeStringToArray(Array a$(1), s$, d$)
; Note: a$ has to be declared and initialized (doesn't matter with what) before calling this procedure.
```

```asm
; Returns: Nonzero if a$ is equal to #Null$ or is filled with spaces.
IsNullOrEmpty(a$)
```
<br>

## [Unit Testing](UnitTest-Basic.pb) (Basic)
[UNFINISHED README]<br>
<br>

## [UUID4](UUID4.pb) ([Lite version](UUID4-Lite.pb))
In both version, you can generate a UUID4 by using the following procedure:
```asm
; Returns: A UUID4 String.
GenerateUUID4()
```
And if you use the [Full version](UUID4.pb), you can use the `#REGEX_ID_UUID4` regex to check if a String matches the UUID4 standard.<br>
<br>

# License
[???](LICENSE)
