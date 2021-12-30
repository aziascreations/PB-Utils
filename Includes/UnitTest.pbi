;{- Code Header
; ==- Basic Info -================================
;         Name: UnitTest-Basic.pbi
;      Version: 3.0.0 - Common to all "PB-Utils" Includes
;       Author: Herwin Bozet
; 
;  Description: ???
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.70 (x86/x64) (Other versions untested)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;  License: Unlicensed
; 
;}


;- Notes
;{

; None

;}


;- Variables & Constants
;{

Global PassedUnitTests.i = 0
Global FailedUnitTests.i = 0

;}


;- Procedures
;{

Procedure Pass(TestName.s="", Reason.s="")
	PassedUnitTests = PassedUnitTests + 1
	If Len(TestName)
		Debug "Passed -> "+TestName
	Else
		Debug "Passed"
	EndIf
	If Len(Reason)
		Debug "|_> "+Reason
	EndIf
EndProcedure

Procedure Fail(TestName.s="", Reason.s="")
	FailedUnitTests = FailedUnitTests + 1
	If Len(TestName)
		Debug "Failed -> "+TestName
	Else
		Debug "Failed"
	EndIf
	If Len(Reason)
		Debug "|_> "+Reason
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

Procedure AssertEqual(Value1, Value2, TestName.s="")
	AssertTrue(Bool(Value1 = Value2), TestName)
EndProcedure

Procedure AssertNotEqual(Value1, Value2, TestName.s="")
	AssertTrue(Bool(Value1 <> Value2), TestName)
EndProcedure

Procedure AssertEqualStr(String1$, String2$, TestName.s="")
	AssertTrue(Bool(String1$ = String2$), TestName)
EndProcedure

Procedure AssertNotEqualStr(String1$, String2$, TestName.s="")
	AssertTrue(Bool(String1$ <> String2$), TestName)
EndProcedure

Procedure AssertBitwiseEqual(Value1, Value2, TestName.s="")
	AssertTrue(Bool(Value1 ! Value2 = 0), TestName)
EndProcedure

Procedure AssertBitwiseNotEqual(Value1, Value2, TestName.s="")
	AssertTrue(Bool(Value1 ! Value2 <> 0), TestName)
EndProcedure

Procedure Assert(Bool.b, TestName.s="")
	AssertTrue(Bool, TestName)
EndProcedure

;}
