; ╔═════════════════════════════════════════════════════════╦════════╗
; ║ Purebasic Utils - Unit Test - Basic                     ║ v1.1.0 ║
; ╠═════════════════════════════════════════════════════════╩════════╣
; ║                                                                  ║
; ║   ???                                                            ║
; ║                                                                  ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Requirements: PB v5.60+ (Not tested with previous versions)      ║
; ╚══════════════════════════════════════════════════════════════════╝

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

; IDE Options = PureBasic 5.60 (Windows - x86)
; CursorPosition = 13
; Folding = --
; EnableXP
; CompileSourceDirectory