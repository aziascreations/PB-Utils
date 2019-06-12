;{- Code Header
; ==- Basic Info -================================
;         Name: Strings.pbi
;      Version: 1.3.1
;       Author: Herwin Bozet & Demivec
;  Create date: ‎‎22 ‎October ‎2017, ‏‎04:37:04
; 
;  Description: ???
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.60-5.62 (x64) (Other versions untested)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Credits -===================================
;  Demivec: ExplodeStringToArray(...)
;           http://www.purebasic.fr/english/viewtopic.php?f=13&t=41704
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;  License: WTFPL
; 
;}

;
;- Compiler Options
;{

; The following line is only use to see if it works with it and for debugging
;EnableExplicit

;}

;
;- Constants
;{

; TODO: Add more
#BOM_UTF8 = $FEFF

;}

;
;- Procedures
;{

; Returns: The number of entries in the Array.
; Source: http://www.purebasic.fr/english/viewtopic.php?f=13&t=41704
Procedure ExplodeStringToArray(Array a$(1), s$, delimeter$, cleanString.b=#True)
	If cleanString
		s$ = Trim(s$, delimeter$)
		
		While FindString(s$, delimeter$+delimeter$)
			s$ = ReplaceString(s$, delimeter$+delimeter$, delimeter$)
		Wend
	EndIf

	Protected count, i
	count = CountString(s$,delimeter$) + 1
	
	Dim a$(count)
	For i = 1 To count
		a$(i - 1) = StringField(s$,i,delimeter$)
	Next
	ProcedureReturn count
EndProcedure

; Returns: Nonzero if a$ is equal to #Null$ or is filled with spaces.
Procedure.b IsNullOrEmpty(a$)
	ProcedureReturn Bool(Trim(a$) = #Null$)
EndProcedure

; Procedure.s Format(text.s, *val1 = 0, *val2 = 0, *val3 = 0, *val4 = 0, *val5 = 0, *val6 = 0, *val7 = 0, *val8 = 0, *val9 = 0, *val10 = 0, *val11 = 0 )
; 	
; 	;http://www.purebasic.fr/english/viewtopic.php?t=32026
; 	
; 	ProcedureReturn #Null$
; EndProcedure

;}

;
;- Unit Tests & Examples
;{

CompilerIf #PB_Compiler_IsMainFile
	XIncludeFile "./UnitTest-Basic.pb"
	
	Debug "Unit tests -> "+Chr(34)+#PB_Compiler_Filename+Chr(34)
	Debug ""
	
	Debug "> ExplodeStringToArray(a$, s$, delimeter$)"
	Alphabet.s = "a;b;c;d;e;f;g;h;i;j;k;l;m;n;o;p;q;r;s;t;u;v;w;x;y;z"
	Dim Letters.s(0)
	Assert(Bool(ExplodeStringToArray(Letters(), Alphabet, ";") = 26), "Returned value (26)")
	Assert(Bool(Letters(0) = "a"), "Letter in Letters(0)")
	Debug ""
	
	Debug "> ExplodeStringToArray(a$, s$, delimeter$, #True)"
	Temp.s = ";a;;b;c;;;;d;"
	Assert(Bool(ExplodeStringToArray(Letters(), Temp, ";", #True) = 4), "Returned value (4)")
	Assert(Bool(Letters(0) = "a"), "Letter in Letters(0)")
	Debug ""
	
	Debug "> ExplodeStringToArray(a$, s$, delimeter$, #False)"
	Assert(Bool(ExplodeStringToArray(Letters(), Temp, ";", #False) = 10), "Returned value (10)")
	Assert(Bool(Letters(0) = ""), "Letter in Letters(0) = nothing")
	Assert(Bool(Letters(1) = "a"), "Letter in Letters(1) = 'a'")
	Debug ""
	
	Debug "> IsNullOrEmpty(a$)"
	Assert(Bool(IsNullOrEmpty("")), "Empty string")
	Assert(Bool(IsNullOrEmpty(#Null$)), "#Null$")
	Assert(Bool(IsNullOrEmpty(Space(3))), Chr(34)+Space(3)+Chr(34))
	AssertFalse(Bool(IsNullOrEmpty("Hello World")), Chr(34)+"Hello World"+Chr(34))
	Debug ""
	
	Debug "-- "+PassedUnitTests+" passed - "+FailedUnitTests+" failed --"
CompilerEndIf

;}

; IDE Options = PureBasic 5.62 (Windows - x64)
; CursorPosition = 18
; Folding = --
; EnableXP
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0