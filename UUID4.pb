; ╔═════════════════════════════════════════════════════════╦════════╗
; ║ Purebasic Utils - UUID4                                 ║ v1.0.1 ║
; ╠═════════════════════════════════════════════════════════╩════════╣
; ║                                                                  ║
; ║   ???                                                            ║
; ║                                                                  ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Requirements: PB v5.50+ (Not tested with previous versions)      ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Source: http://www.purebasic.fr/english/viewtopic.php?t=38008    ║
; ╚══════════════════════════════════════════════════════════════════╝

Enumeration Regex
	#REGEX_ID_UUID4
EndEnumeration

Enumeration ErrorCode
	#_ERR_REGEX_UUID4CreationFailure
EndEnumeration

#_REGEX_UUID4 = "^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$"

Debug "Creating UUID4 regex..."
If Not CreateRegularExpression(#REGEX_ID_UUID4, #_REGEX_UUID4)
	Debug "Failed to create UUID4 regex !"
	; TODO: Add a MessageRequester ?
	End #_ERR_REGEX_UUID4CreationFailure
EndIf

; Returns a UUID4 as a String
Procedure.s GenerateUUID4()
	Dim _UUID4Bytes.b(16)
	
	For i=0 To 16-1
		_UUID4Bytes(i)=Random(255)
	Next
	_UUID4Bytes(6)=64+Random(15)
	_UUID4Bytes(8)=128+Random(63)
	
	For i=0 To 16-1
		If i=4 Or i=6 Or i=8 Or i=10
			UUID.s+"-"
		EndIf
		UUID.s+RSet(Hex(_UUID4Bytes(i)&$FF),2,"0")
	Next
	
	FreeArray(_UUID4Bytes())
	ProcedureReturn UUID.s
EndProcedure

;
;- Tests & Examples
;{

CompilerIf #PB_Compiler_IsMainFile
	For i=0 To 10
		Debug GenerateUUID4()
	Next
CompilerEndIf
;}

; IDE Options = PureBasic 5.60 (Windows - x86)
; CursorPosition = 49
; FirstLine = 7
; Folding = -
; EnableXP
; CompileSourceDirectory