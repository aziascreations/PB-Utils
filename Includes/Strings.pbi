;{- Code Header
; ==- Basic Info -================================
;         Name: Strings.pbi
;      Version: 3.0.0 - Common to all "PB-Utils" Includes
;       Author: Herwin Bozet
;
;  Description: Contains a set of procedures to manipulate string more easily if you need to.
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.70 (x86/x64) (Other versions untested)
;  Operating system: Windows (Other platforms untested)
;
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;     Doc.: https://github.com/aziascreations/PB-Utils/Documentation/Strings
;  License: Unlicensed
;
;}


;- Compiler Options
;{

; The following line is only use to see if it works with it and for debugging
;EnableExplicit

;}


;- Procedures
;{

; Returns the number of distinct entries in the given Array A$() and populates it with each part.
Procedure.q SplitArrayToString(Array A$(1), StringToSplit$, Delimeter$, CleanString.b=#True)
	Protected DelimiterCount.q, i.q

	If CleanString
		StringToSplit$ = Trim(StringToSplit$, Delimeter$)

		While FindString(StringToSplit$, Delimeter$+Delimeter$)
			StringToSplit$ = ReplaceString(StringToSplit$, Delimeter$+Delimeter$, Delimeter$)
		Wend
	EndIf

	DelimiterCount = CountString(StringToSplit$,Delimeter$)

	Dim A$(DelimiterCount)
	For i = 0 To DelimiterCount
		A$(i) = StringField(StringToSplit$,i+1,Delimeter$)
	Next

	ProcedureReturn DelimiterCount + 1
EndProcedure


; Returns nonzero if A$ is equal to #Null$ or is filled with spaces.
Procedure.b IsNullOrEmpty(A$)
	ProcedureReturn Bool(Trim(A$) = #Null$)
EndProcedure


; Returns the largest common prefix in the given A$ and B$ strings.
Procedure.s CommonPrefix(A$, B$)
	Protected MaxPrefixLength.q, PrefixIndex.q
	
	If Len(A$) > Len(B$)
		MaxPrefixLength = Len(A$)
	Else
		MaxPrefixLength = Len(B$)
	EndIf
	
	For PrefixIndex = 1 To MaxPrefixLength
		If Mid(A$, PrefixIndex, 1) <> Mid(B$, PrefixIndex, 1)
			Break
		EndIf
	Next
	
	ProcedureReturn Left(A$, PrefixIndex - 1)
EndProcedure


; Returns the length of the largest common prefix in the given A$ and B$ strings.
Procedure.q CommonPrefixLength(A$, B$)
	Protected MaxPrefixLength.q, PrefixIndex.q
	
	If Len(A$) > Len(B$)
		MaxPrefixLength = Len(A$)
	Else
		MaxPrefixLength = Len(B$)
	EndIf
	
	For PrefixIndex = 1 To MaxPrefixLength
		If Mid(A$, PrefixIndex, 1) <> Mid(B$, PrefixIndex, 1)
			Break
		EndIf
	Next
	
	ProcedureReturn PrefixIndex - 1
EndProcedure

;}


;- Tests
;{

CompilerIf #PB_Compiler_IsMainFile
	Define InputString.s, Temp.s, Dim Letters.s(0), i.i

	; -------------------------------------------------------
	;  SplitArrayToString(A$, StringToSplit$, Delimeter$)
	;  "a;b;c;d;e;f;g;h;i;j;k;l;m;n;o;p;q;r;s;t;u;v;w;x;y;z"
	; -------------------------------------------------------
	Debug "> SplitArrayToString(A$, StringToSplit$, Delimeter$)"
	InputString = "a;b;c;d;e;f;g;h;i;j;k;l;m;n;o;p;q;r;s;t;u;v;w;x;y;z"
	
	Debug #TAB$ + "Using: "+Chr(34)+InputString+Chr(34)
	Debug #TAB$ + "Length: "+SplitArrayToString(Letters(), InputString, ";")

	Temp = "["
	For i=0 To ArraySize(Letters())
		Temp + Letters(i) + " ,"
	Next
	Temp = Left(Temp, Len(Temp) - 2) + "]"

	Debug #TAB$ + "Array: "+Temp
	Debug ""


	; -------------------------------------------------
	;  SplitArrayToString(A$, StringToSplit$, Delimeter$, #True)
	;  ";a;;b;c;;;;d;"
	; -------------------------------------------------
	Debug "> SplitArrayToString(A$, StringToSplit$, Delimeter$, #True)"
	InputString = ";a;;b;c;;;;d;"

	Debug #TAB$ + "Using: "+Chr(34)+InputString+Chr(34)
	Debug #TAB$ + "Length: "+SplitArrayToString(Letters(), InputString, ";", #True)

	Temp = "["
	For i=0 To ArraySize(Letters())
		Temp + Letters(i) + " ,"
	Next
	Temp = Left(Temp, Len(Temp) - 2) + "]"

	Debug #TAB$ + "Array: "+Temp
	Debug ""


	; --------------------------------------------------
	;  SplitArrayToString(A$, StringToSplit$, Delimeter$, #False)
	;  ";a;;b;c;;;;d;"
	; --------------------------------------------------
	Debug "> SplitArrayToString(A$, StringToSplit$, Delimeter$, #False)"
	Debug #TAB$ + "Using: "+Chr(34)+InputString+Chr(34)
	Debug #TAB$ + "Length: "+SplitArrayToString(Letters(), InputString, ";", #False)

	Temp = "["
	For i=0 To ArraySize(Letters())
		Temp + Letters(i) + " ,"
	Next
	Temp = Left(Temp, Len(Temp) - 2) + "]"

	Debug #TAB$ + "Array: "+Temp
	Debug ""


	; -------------------
	;  IsNullOrEmpty(A$)
	; -------------------
	Debug "> IsNullOrEmpty(A$)"

	If IsNullOrEmpty("") = #True
		Debug #TAB$+"Empty string -> True"
	Else
		Debug #TAB$+"Empty string -> False (ERROR !!!)"
	EndIf

	If IsNullOrEmpty(#Null$) = #True
		Debug #TAB$+"#Null$ -> True"
	Else
		Debug #TAB$+"#Null$ -> False (ERROR !!!)"
	EndIf

	If IsNullOrEmpty(Space(3)) = #True
		Debug #TAB$+"Space(3) -> True"
	Else
		Debug #TAB$+"Space(3) -> False (ERROR !!!)"
	EndIf

	If IsNullOrEmpty("Hello World") = #False
		Debug #TAB$+Chr(34)+"Hello World"+Chr(34)+" -> False"
	Else
		Debug #TAB$+Chr(34)+"Hello World"+Chr(34)+" -> True (ERROR !!!)"
	EndIf

	Debug ""
	
	
	; ------------------------
	;  CommonPrefix(A$, B$)
	;  CommonPrefixLength(A$, B$)
	; ------------------------
	Debug "> CommonPrefix(A$, B$) & CommonPrefixLength(A$, B$)"
	
	Define String1$, String2$
	
	String1$ = "Hello World !"
	String2$ = "Hello !"
	
	Debug #TAB$ + "Using: " + Chr(34) + String1$ + Chr(34) + " & " + Chr(34) + String2$ + Chr(34)
	Debug #TAB$ + "Common Prefix: "+ Chr(34) + CommonPrefix(String1$, String2$) + Chr(34)
	Debug #TAB$ + "Prefix Length: "+ CommonPrefixLength(String1$, String2$)+#CRLF$
	
	String1$ = "Hi !"
	String2$ = "Hi !"
	
	Debug #TAB$ + "Using: " + Chr(34) + String1$ + Chr(34) + " & " + Chr(34) + String2$ + Chr(34)
	Debug #TAB$ + "Common Prefix: "+ Chr(34) + CommonPrefix(String1$, String2$) + Chr(34)
	Debug #TAB$ + "Prefix Length: "+ CommonPrefixLength(String1$, String2$)+#CRLF$
	
	String1$ = "Melk"
	String2$ = "Lait"
	
	Debug #TAB$ + "Using: " + Chr(34) + String1$ + Chr(34) + " & " + Chr(34) + String2$ + Chr(34)
	Debug #TAB$ + "Common Prefix: "+ Chr(34) + CommonPrefix(String1$, String2$) + Chr(34)
	Debug #TAB$ + "Prefix Length: "+ CommonPrefixLength(String1$, String2$)+#CRLF$
	
CompilerEndIf

;}
