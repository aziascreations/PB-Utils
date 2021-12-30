;{- Code Header
; ==- Basic Info -================================
;         Name: UUID4.pbi
;      Version: 3.0.0 - Common to all "PB-Utils" Includes
;       Author: Herwin Bozet
;
;  Description: ???
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.70 (x86/x64) (Other versions untested)
;  Operating system: Windows (Other platforms untested)
;
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;     Doc.: https://github.com/aziascreations/PB-Utils/wiki/UUID4
;  License: Unlicensed
;
;}

; TODO: Add a generate UUID4 Buffer
; TODO: Add a parameter to use SecureRandom(...)

;
;- Compiler Options
;{

; The following line is only use to see if it works with it and for debugging
EnableExplicit

;}

;
;- Variables & Constants
;{

Enumeration Regex
	#REGEX_ID_UUID4
EndEnumeration

Enumeration ErrorCode
	#ERR_REGEX_UUID4CreationFailure
EndEnumeration

#REGEX_UUID4 = "^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$"

Debug "Creating UUID4 regex..."
If Not CreateRegularExpression(#REGEX_ID_UUID4, #REGEX_UUID4)
	Debug "Failed to create UUID4 regex !"
	; TODO: Add a MessageRequester ?
	End #ERR_REGEX_UUID4CreationFailure
EndIf

;}

;
;- Procedures
;{

; Returns a UUID4 as a String
Procedure.s GenerateUUID4()
	Define.b i
	Define.s UUID
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

; Returns a non-zero value If the string matches the UUID4 regex.
Procedure IsUUID4Compliant(uuid4$)
	ProcedureReturn MatchRegularExpression(#REGEX_ID_UUID4, uuid4$)
EndProcedure

;}
