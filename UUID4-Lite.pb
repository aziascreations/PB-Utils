; ╔═════════════════════════════════════════════════════════╦════════╗
; ║ Purebasic Utils - UUID4 Lite                            ║ v1.0.0 ║
; ╠═════════════════════════════════════════════════════════╩════════╣
; ║                                                                  ║
; ║   ???                                                            ║
; ║                                                                  ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Requirements: PB v5.50+ (Not tested with previous versions)      ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Source: http://www.purebasic.fr/english/viewtopic.php?t=38008    ║
; ╚══════════════════════════════════════════════════════════════════╝

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

; IDE Options = PureBasic 5.60 (Windows - x86)
; Folding = -
; EnableXP
; CompileSourceDirectory