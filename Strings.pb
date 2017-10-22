
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

; IDE Options = PureBasic 5.50 (Windows - x64)
; CursorPosition = 6
; Folding = -
; EnableXP