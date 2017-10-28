; ╔═════════════════════════════════════════════════════════╦════════╗
; ║ Purebasic Utils - Unit Test - Basic                     ║ v1.0.0 ║
; ╠═════════════════════════════════════════════════════════╩════════╣
; ║                                                                  ║
; ║   ???                                                            ║
; ║                                                                  ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Requirements: PB v5.60+ (Not tested with previous versions)      ║
; ╚══════════════════════════════════════════════════════════════════╝

Global PassedTests.i = 0
Global FailedTests.i = 0

Procedure Pass(TestName.s="")
	PassedTests = PassedTests + 1
	If Len(TestName)
		Debug "Passed -> "+TestName
	Else
		Debug "Passed"
	EndIf
EndProcedure

Procedure Fail(TestName.s="")
	FailedTests = FailedTests + 1
	If Len(TestName)
		Debug "Failed -> "+TestName
	Else
		Debug "Failed"
	EndIf
EndProcedure

Procedure AssertTrue(Bool.b, TestName.s="")
	If Bool
		Pass(TestName)
	Else
		Fail(TestName)
	EndIf
EndProcedure

Procedure AssertFalse(Bool.b, TestName.s="")
	If Bool
		Fail(TestName)
	Else
		Pass(TestName)
	EndIf
EndProcedure

Procedure Assert(Bool.b, TestName.s="")
	AssertTrue(Bool, TestName)
EndProcedure
; IDE Options = PureBasic 5.60 (Windows - x86)
; CursorPosition = 7
; Folding = -
; EnableXP
; CompileSourceDirectory