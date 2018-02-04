; ╔═════════════════════════════════════════════════════════╦════════╗
; ║ Purebasic Utils - Unit Test - Basic                     ║ v1.0.0 ║
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
Global PassedTests.i = 0
Global FailedTests.i = 0

;}

;
;- Procedures
;{

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

; Why the fuck isn't there a default value for Bool.b ?
; What... I'm starting to wonder if I'm not losing it when I read this kind
;  of shit, what the hell was I thinking when I wrote this procedure ?
; Yeah..., caffeine and hot chocolate don't help when you are sleep deprived...
; I couldn't even understand a 5 line procedure...
; And to respond to the original question: Because there are 2 fucking procedures
;  above this one for this...
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

;}

; IDE Options = PureBasic 5.60 (Windows - x86)
; CursorPosition = 34
; Folding = --
; EnableXP
; CompileSourceDirectory