;{- Code Header
; ==- Basic Info -================================
;         Name: UnitTest-Basic.pbi
;      Version: 1.1.0
;       Author: Herwin Bozet & Demivec
;  Create date: 27 October 2017, 01:25:46
; 
;  Description: ???
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.60-5.62 (x64) (Other versions untested)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;  License: WTFPL
; 
;}

;TODO?: Add a EndUnitTesting procedure that prints the number of failed and passed tests

;
;- Compiler Options
;{

; The following line is only use to see if it works with it and for debugging
;EnableExplicit

;}

;
;- Variables & Constants
;{

Global PassedUnitTests.i = 0
Global FailedUnitTests.i = 0

;}

;
;- Procedures
;{

Procedure Pass(TestName.s="")
	PassedUnitTests = PassedUnitTests + 1
	If Len(TestName)
		Debug "Passed -> "+TestName
	Else
		Debug "Passed"
	EndIf
EndProcedure

Procedure Fail(TestName.s="")
	FailedUnitTests = FailedUnitTests + 1
	If Len(TestName)
		Debug "Failed -> "+TestName
	Else
		Debug "Failed"
	EndIf
EndProcedure

Procedure AssertTrue(Bool.b=#True, TestName.s="")
	If Bool
		Pass(TestName)
	Else
		Fail(TestName)
	EndIf
EndProcedure

Procedure AssertFalse(Bool.b=#False, TestName.s="")
	If Bool
		Fail(TestName)
	Else
		Pass(TestName)
	EndIf
EndProcedure

Procedure Assert(Bool.b, TestName.s="")
	AssertTrue(Bool, TestName)
EndProcedure

;}

; IDE Options = PureBasic 5.62 (Windows - x64)
; CursorPosition = 16
; Folding = --
; EnableXP
; CompileSourceDirectory