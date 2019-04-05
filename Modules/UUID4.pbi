;{- Code Header
; ==- Basic Info -================================
;         Name: UUID4.pbi
;      Version: 1.1.0
;       Author: Herwin Bozet
;  Create date: ‎11 ‎February ‎2018, ‏‎21:13:39
; 
;  Description: ???
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.60-5.62 (x64) (Other versions untested)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;     Doc.: https://github.com/aziascreations/PB-Utils/wiki/UUID4
;  License: Apache V2
; 
;}

;
;- Module (Public)
;{

DeclareModule UUID4
	;- > Constants
	;{
	
	Enumeration Regex
		#REGEX_ID_UUID4
	EndEnumeration
	
	Enumeration ErrorCode
		#ERR_REGEX_UUID4CreationFailure
	EndEnumeration
	
	#REGEX_UUID4 = "^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$"
	#VERSION$ = "1.1.0"
	#VERSION = 6
	
	;}
	;- > Procedures declaration
	;{
	
	Declare.s GenerateUUID4()
	Declare.b IsUUID4Compliant(uuid4$)
	
	;}
	
EndDeclareModule

;}
;- Module (Private)
;{

Module UUID4
	;- Import code
	;{
	
	; The following line is only use to see if it works with it and for debugging
	;EnableExplicit
	
	Debug "Creating UUID4 regex..."
	If Not CreateRegularExpression(#REGEX_ID_UUID4, #REGEX_UUID4)
		Debug "Failed to create UUID4 regex !"
		; TODO: Add a MessageRequester ?
		End #ERR_REGEX_UUID4CreationFailure
	EndIf
	
	;}
	;- > Procedures
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
	Procedure.b IsUUID4Compliant(uuid4$)
		ProcedureReturn MatchRegularExpression(#REGEX_ID_UUID4, uuid4$)
	EndProcedure
	
	;}
	
EndModule

;}
;- Unit Tests & Examples
;{

CompilerIf #PB_Compiler_IsMainFile
	; The path will be changed later
	XIncludeFile "../UnitTest-Basic.pb"
	
	Debug "Unit tests -> "+Chr(34)+#PB_Compiler_Filename+Chr(34)
	Debug ""
	
	Debug "> UUID4::GenerateUUID4()"
	For i=0 To 5
		Debug UUID4::GenerateUUID4()
	Next
	Pass("UUID Generation")
	Debug ""
	
	If FailedUnitTests
		Debug "ERROR: The ability to generate UUID4 string is required for the other unit tests"
		End 1
	EndIf
	
	Debug "> IsUUID4Compliant(uuid4$)"
	Assert(UUID4::IsUUID4Compliant(UUID4::GenerateUUID4()), "UUID4 validity check")
	Debug ""
	
	Debug "-- "+PassedUnitTests+" passed - "+FailedUnitTests+" failed --"
CompilerEndIf

;}

; IDE Options = PureBasic 5.62 (Windows - x64)
; Folding = ---
; EnableXP
; CompileSourceDirectory
; EnableCompileCount = 1
; EnableBuildCount = 0