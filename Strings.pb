; ╔═════════════════════════════════════════════════════════╦════════╗
; ║ Purebasic Utils - Strings                               ║ v1.1.0 ║
; ╠═════════════════════════════════════════════════════════╩════════╣
; ║                                                                  ║
; ║   ???                                                            ║
; ║                                                                  ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Requirements: PB v5.60+ (Not tested with previous versions)      ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Sources: See the comments of each procedure                      ║
; ╚══════════════════════════════════════════════════════════════════╝

; Returns: 
; Source: http://www.purebasic.fr/english/viewtopic.php?f=13&t=41704
Procedure ExplodeStringToArray(Array a$(1), s$, delimeter$)
	Protected count, i
	count = CountString(s$,delimeter$) + 1
	
	;Debug Str(count) + " substrings found in ("+s$+")"
	Dim a$(count)
	For i = 1 To count
		a$(i - 1) = StringField(s$,i,delimeter$)
	Next
	ProcedureReturn count
EndProcedure

; Returns: Nonzero if a$ is equal to #Null$ or is filled with spaces.
Procedure IsNullOrEmpty(a$)
	ProcedureReturn Bool(a$ = #Null$ Or Not Len(ReplaceString(a$, " ", "")))
EndProcedure


;
;- Unit Tests
;

CompilerIf #PB_Compiler_IsMainFile
	XIncludeFile "./UnitTest-Basic.pb"
	
	Debug "Unit tests -> "+Chr(34)+#PB_Compiler_Filename+Chr(34)
	
	Debug "> IsNullOrEmpty(a$)"
	Debug "No unit test currently available"
	Debug ""
	
	Debug "> IsNullOrEmpty(a$)"
	Assert(Bool(IsNullOrEmpty("")), "Empty string")
	Assert(Bool(IsNullOrEmpty(#Null$)), "#Null$")
	Assert(Bool(IsNullOrEmpty(Space(3))), Chr(34)+Space(3)+Chr(34))
	AssertFalse(Bool(IsNullOrEmpty("Hello World")), Chr(34)+"Hello World"+Chr(34))
	Debug ""
	
	Debug "-- "+PassedTests+" passed - "+FailedTests+" failed --"
CompilerEndIf

; IDE Options = PureBasic 5.60 (Windows - x86)
; CursorPosition = 31
; Folding = -
; EnableXP
; CompileSourceDirectory