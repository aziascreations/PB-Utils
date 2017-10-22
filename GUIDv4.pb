
; WARNING: Might not follow the standard !

; Source: http://www.purebasic.fr/english/viewtopic.php?t=38008

Structure UUID4
	Byte.b[16]
EndStructure

Procedure.s GenerateGUIDv4()
	Define UUID.UUID4
	For i=0 To 16-1
		UUID\Byte[i]=Random(255)
	Next
	UUID\Byte[9]=128+Random(63)
	UUID\Byte[7]=64+Random(15)
	
	For i=0 To 16-1
		If i=3 Or i=5 Or i=7
			GUID.s+"-"
		EndIf
		GUID.s+RSet(Hex(UUID\Byte[i]&$FF),2,"0")
	Next
	
	ProcedureReturn GUID.s
EndProcedure

; IDE Options = PureBasic 5.50 (Windows - x64)
; CursorPosition = 1
; Folding = -
; EnableXP