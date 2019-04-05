;{- Code Header
; ==- Basic Info -================================
;         Name: SemanticVersionning.pbi
;      Version: 1.0.1
;       Author: Herwin Bozet
;  Create date: ‎2 ‎February ‎2018, ‏‎13:05:32
; 
;  Description: ???
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.60-5.62 (x64) (Other versions untested)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;     Doc.: https://semver.org/
;  License: Apache V2
; 
;}

; This will only be a basic semantic versioning checker since I don't want
;  to have to check the parts after the minus sign because dumb users can
;  fuck it up in an infinite number of ways and I don't want to bother with that

; If I don't Redim the arrays to 0 at the end of the procedure is there a chance
;  that a memory leak occurs ?
; If yes, use a temporary Global variable.

;
;- Compiler Options
;{

; The following line is only use to see if it works with it and for debugging
;EnableExplicit

XIncludeFile "Strings.pb"

;}

;
;- Variables & Constants
;{

Enumeration Regex
	#REGEX_ID_SEMVER
EndEnumeration

Enumeration ErrorCode
	#ERR_REGEX_InvalidVersion
	#ERR_SEMVER_InvalidVersion
EndEnumeration

#_REGEX_SemVer = "^([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?(?:\+[0-9A-Za-z-]+)?$"

Global Semver_CanEndProgram.b = #True
Global Semver_CanShowMessages.b = #False

;}

;
;- Procedures
;{

Procedure.b InitializeSemVer(CanShowMessages.b=#False, CanEndProgram.b=#True)
	Semver_CanEndProgram = CanEndProgram
	Semver_CanShowMessages = CanShowMessages
	
	Debug "Creating Semantic Versionning regex..."
	If Not CreateRegularExpression(#REGEX_ID_SEMVER, #_REGEX_SemVer)
		Debug "Failed to create Semantic Versionning regex !"
		
		If CanShowMessages
			MessageRequester("Fatal Error", "Unable to create regex for semantic versioning.", #PB_MessageRequester_Error)
		EndIf
		
		If CanEndProgram
			End #ERR_REGEX_InvalidVersion
		EndIf
		
		ProcedureReturn #False
	EndIf
	ProcedureReturn #True
EndProcedure

Procedure.b IsVersionValid(Version.s, DoValidityCheck=#True)
	If Not DoValidityCheck
		ProcedureReturn #True
	EndIf
	
	ProcedureReturn MatchRegularExpression(#REGEX_ID_SEMVER, Version)
	;ProcedureReturn #True
EndProcedure

Procedure.s GetVersionNumber(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)
	If Not IsVersionValid(Version, DoValidityCheck)
		CompilerIf #PB_Compiler_IsIncludeFile
			Debug "The given version is invalid and can't be worked on ("+Version+")"
		CompilerEndIf
		
		If CanShowMessages Or (CanShowMessages And Semver_CanShowMessages)
			MessageRequester("Fatal Error", "HI", #PB_MessageRequester_Error)
		EndIf
		
		If CanEndProgram Or (CanEndProgram And Semver_CanEndProgram)
			End #ERR_SEMVER_InvalidVersion
		EndIf
		
		ProcedureReturn "-1.-1.-1"
	EndIf
	
	Dim VersionParts.s(0)
	ExplodeStringToArray(VersionParts(), Version, "-")
	ExplodeStringToArray(VersionParts(), VersionParts(0), "+")
	
	ProcedureReturn VersionParts(0)
EndProcedure

Procedure.b GetVersionMajor(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)
	If Not IsVersionValid(Version, DoValidityCheck)
		CompilerIf #PB_Compiler_IsIncludeFile
			Debug "The given version is invalid and can't be worked on ("+Version+")"
		CompilerEndIf
		
		If CanShowMessages Or (CanShowMessages And Semver_CanShowMessages)
			MessageRequester("Fatal Error", "HI", #PB_MessageRequester_Error)
		EndIf
		
		If CanEndProgram Or (CanEndProgram And Semver_CanEndProgram)
			End #ERR_SEMVER_InvalidVersion
		EndIf
		
		ProcedureReturn -1
	EndIf
	
	Version = GetVersionNumber(Version, CanShowMessages, CanEndProgram, DoValidityCheck)
	
	Dim VersionNumbers.s(0)
	ExplodeStringToArray(VersionNumbers(), Version, ".")
	
	ProcedureReturn Val(VersionNumbers(0))
EndProcedure

Procedure.b GetVersionMinor(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)
	If Not IsVersionValid(Version, DoValidityCheck)
		CompilerIf #PB_Compiler_IsIncludeFile
			Debug "The given version is invalid and can't be worked on ("+Version+")"
		CompilerEndIf
		
		If CanShowMessages Or (CanShowMessages And Semver_CanShowMessages)
			MessageRequester("Fatal Error", "HI", #PB_MessageRequester_Error)
		EndIf
		
		If CanEndProgram Or (CanEndProgram And Semver_CanEndProgram)
			End #ERR_SEMVER_InvalidVersion
		EndIf
		
		ProcedureReturn -1
	EndIf
	
	Version = GetVersionNumber(Version, CanShowMessages, CanEndProgram, DoValidityCheck)
	
	Dim VersionNumbers.s(0)
	ExplodeStringToArray(VersionNumbers(), Version, ".")
	
	ProcedureReturn Val(VersionNumbers(1))
EndProcedure

Procedure.b GetVersionPatch(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)
	If Not IsVersionValid(Version, DoValidityCheck)
		CompilerIf #PB_Compiler_IsIncludeFile
			Debug "The given version is invalid and can't be worked on ("+Version+")"
		CompilerEndIf
		
		If CanShowMessages Or (CanShowMessages And Semver_CanShowMessages)
			MessageRequester("Fatal Error", "HI", #PB_MessageRequester_Error)
		EndIf
		
		If CanEndProgram Or (CanEndProgram And Semver_CanEndProgram)
			End #ERR_SEMVER_InvalidVersion
		EndIf
		
		ProcedureReturn -1
	EndIf
	
	Version = GetVersionNumber(Version, CanShowMessages, CanEndProgram, DoValidityCheck)
	
	Dim VersionNumbers.s(0)
	ExplodeStringToArray(VersionNumbers(), Version, ".")
	
	ProcedureReturn Val(VersionNumbers(2))
EndProcedure

; Procedure.b IsVersionCompatible(VersionA.s, VersionB.s)
; 	
; EndProcedure

;}

;
;- Unit Tests & Examples
;{

CompilerIf #PB_Compiler_IsMainFile
	XIncludeFile "UnitTest-Basic.pb"
	
	Debug "Unit tests -> "+Chr(34)+#PB_Compiler_Filename+Chr(34)
	Debug ""
	
	Debug "> InitializeSemVer(#False, #False)"
	Assert(InitializeSemVer(#False, #False), "Initialization")
	Debug ""
	
	If FailedUnitTests
		Debug "ERROR: The success of the initialiization is required for the other procedures."
		End 1
	EndIf
	
	Debug "> IsVersionValid(Version.s, #True)"
	AssertTrue(IsVersionValid("1.0.0-abc+abc", #True), "1.0.0-abc+abc (Valid)")
	AssertTrue(IsVersionValid("1.0.0-alpha1.0.0+build156", #True), "1.0.0-alpha1.0+build156 (Valid)")
	AssertFalse(IsVersionValid("1.0.0-alpha1.0.0+build156.12", #True), "1.0.0-alpha1.0+build156.12 (Invalid)")
	AssertFalse(IsVersionValid("1.0.0.0", #True), "1.0.0.0  (Invalid)")
	Debug ""
	
	Debug "> GetVersionNumber(Version.s, #False, #False, #False)"
	Assert(Bool(GetVersionNumber("1.0.0-abc+abc", #False, #False, #False) = "1.0.0"), "1.0.0-abc+abc -> 1.0.0")
	Assert(Bool(GetVersionNumber("1.0.0.0-abc+abc", #False, #False, #False) = "1.0.0.0"), "1.0.0.0-abc+abc -> 1.0.0.0 (The procedure only clean the string thinking it's a valid one)")
	Assert(Bool(GetVersionNumber("unverified-stuff", #False, #False, #False) = "unverified"), "unverified-stuff -> unverified (Same as above)")
	Debug ""
	
	Debug "> GetVersionNumber(Version.s, #False, #False, #True)"
	Assert(Bool(GetVersionNumber("1.0.0-abc+abc", #False, #False, #True) = "1.0.0"), "1.0.0-abc+abc -> 1.0.0")
	Assert(Bool(GetVersionNumber("1.0.0.0-abc+abc", #False, #False, #True) = "-1.-1.-1"), "1.0.0.0-abc+abc -> -1.-1.-1 (Forced invalid version to force error trigerring, but still parsable later)")
	Assert(Bool(GetVersionNumber("invalid-stuff", #False, #False, #True) = "-1.-1.-1"), "invalid-stuff -> -1.-1.-1 (Same as above)")
	Debug ""
	
	Debug "> GetVersionMajor(Version.s, #False, #False, #True/#False)"
	Assert(Bool(GetVersionMajor("1.2.3", #False, #False, #True) = 1), "1.2.3 -> 1")
	Assert(Bool(GetVersionMajor("1.0.0.0", #False, #False, #True) = -1), "1.0.0.0 -> -1 (Invalid)")
	Assert(Bool(GetVersionMajor("1.2.3.4", #False, #False, #False) = 1), "1.2.3.4 -> 1 (Invalid, but unchecked)")
	Debug ""
	
	Debug "> GetVersionMinor(Version.s, #False, #False, #True/#False)"
	Assert(Bool(GetVersionMinor("1.2.3", #False, #False, #True) = 2), "1.2.3 -> 2")
	Assert(Bool(GetVersionMinor("1.0.0.0", #False, #False, #True) = -1), "1.0.0.0 -> -1 (Invalid)")
	Assert(Bool(GetVersionMinor("1.2.3.4", #False, #False, #False) = 2), "1.2.3.4 -> 2 (Invalid, but unchecked)")
	Debug ""
	
	Debug "> GetVersionPatch(Version.s, #False, #False, #True/#False)"
	Assert(Bool(GetVersionPatch("1.2.3", #False, #False, #True) = 3), "1.2.3 -> 3")
	Assert(Bool(GetVersionPatch("1.0.0.0", #False, #False, #True) = -1), "1.0.0.0 -> -1 (Invalid)")
	Assert(Bool(GetVersionPatch("1.2.3.4", #False, #False, #False) = 3), "1.2.3.4 -> 3 (Invalid, but unchecked)")
	Debug ""
	
	If FailedUnitTests
		Debug "ERROR: The previously tested procedures need to work in order for the following tests to work."
		End 1
	EndIf
	
	Debug "-- "+PassedUnitTests+" passed - "+FailedUnitTests+" failed --"
CompilerEndIf

;}

; IDE Options = PureBasic 5.62 (Windows - x64)
; CursorPosition = 17
; FirstLine = 3
; Folding = ---
; EnableXP
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0