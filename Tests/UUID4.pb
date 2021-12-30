;{- Code Header
; ==- Test Info -=================================
;  Tested file(s): Includes/UUID.pbi
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.62-5.70 (x86/x64)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;  License: WTFPL
; 
;}


;- Test Setup
;{

EnableExplicit
XIncludeFile "../Includes/UnitTest.pbi"
XIncludeFile "../Includes/UUID4.pbi"

;}


;- Tests
;{

;- > Remarks()
Debug "-=# Remarks #=-"
Debug " * ???"
Debug ""

CompilerIf #PB_Compiler_IsMainFile
	Define i.i

	XIncludeFile "UnitTest-Basic.pb"

	Debug "Unit tests -> "+Chr(34)+#PB_Compiler_Filename+Chr(34)
	Debug ""

	Debug "> GenerateUUID4()"
	For i=0 To 5
		Debug GenerateUUID4()
	Next
	Pass("UUID Generation")
	Debug ""

	If FailedUnitTests
		Debug "ERROR: The ability to generate UUID4 string is required for the other unit tests"
		End 1
	EndIf

	Debug "> IsUUID4Compliant(uuid4$)"
	Assert(IsUUID4Compliant(GenerateUUID4()), "UUID4 validity check")
	Debug ""

	Debug "-- "+PassedUnitTests+" passed - "+FailedUnitTests+" failed --"
CompilerEndIf

;- > Results
Debug "-=# Results #=-"
Debug " * Passed: "+Str(PassedUnitTests)
Debug " * Failed: "+Str(FailedUnitTests)

;}
