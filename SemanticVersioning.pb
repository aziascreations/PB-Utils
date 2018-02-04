; ╔═════════════════════════════════════════════════════════╦════════╗
; ║ Purebasic Utils - Semantic Versionning                  ║ v1.0.0 ║
; ╠═════════════════════════════════════════════════════════╩════════╣
; ║ Requirements: * PB v5.60+ (Not tested with previous versions)    ║
; ║               * Strings.pb 1.3.0+ (From this set of utils)       ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Enumerations: * Regex (RegexID)                                  ║
; ║               * ErrorCode                                        ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Ressource: https://semver.org/                                   ║
; ╚══════════════════════════════════════════════════════════════════╝

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

Procedure.b IsVersionValid(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)
	ProcedureReturn #True
EndProcedure

Procedure.s GetVersionNumber(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)
	If DoValidityCheck
		If Not IsVersionValid(Version)
			Debug "The given version is invalid and can't be worked on ("+Version+")"
			
			If CanShowMessages Or (CanShowMessages And Semver_CanShowMessages)
				MessageRequester("Fatal Error", "HI", #PB_MessageRequester_Error)
			EndIf
			
			If CanEndProgram Or (CanEndProgram And Semver_CanEndProgram)
				End #ERR_SEMVER_InvalidVersion
			EndIf
			
			; Returns a version filled with "-1" to "force" an error in the other
			;  internal procedures that call this one since the first check happens before.
			;  calling this procedure.
			; BTW, this part of the code should never execute under normal conditions if it is.
			;  called from the other internal procedures.
			; It's still there in case some people need it and fuck up.
			ProcedureReturn "-1.-1.-1"
		EndIf
	EndIf
	
	Dim VersionParts.s(0)
	ExplodeStringToArray(VersionParts(), Version, "-")
	ExplodeStringToArray(VersionParts(), VersionParts(0), "+")
	
	ProcedureReturn VersionParts(0)
EndProcedure

Procedure.b GetVersionMajor(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)
	If DoValidityCheck
		If Not IsVersionValid(Version, CanShowMessages, CanEndProgram, #False)
			Debug "ERR1"
		EndIf
	EndIf
	
	Version = GetVersionNumber(Version)
	
	Dim VersionNumbers.s(0)
	ExplodeStringToArray(VersionNumbers(), Version, ".")
	
	ProcedureReturn Val(VersionNumbers(0))
EndProcedure

Procedure.b GetVersionMinor(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)
	If DoValidityCheck
		If Not IsVersionValid(Version, CanShowMessages, CanEndProgram, #False)
			Debug "ERR2"
		EndIf
	EndIf
	
	Version = GetVersionNumber(Version)
	
	Dim VersionNumbers.s(0)
	ExplodeStringToArray(VersionNumbers(), Version, ".")
	
	ProcedureReturn Val(VersionNumbers(1))
EndProcedure

Procedure.b GetVersionPatch(Version.s, CanShowMessages.b=#False, CanEndProgram.b=#True, DoValidityCheck=#True)
	If DoValidityCheck
		If Not IsVersionValid(Version, CanShowMessages, CanEndProgram, #False)
			Debug "ERR3"
		EndIf
	EndIf
	
	Version = GetVersionNumber(Version)
	
	Dim VersionNumbers.s(0)
	ExplodeStringToArray(VersionNumbers(), Version, ".")
	
	ProcedureReturn Val(VersionNumbers(2))
EndProcedure

Procedure.b IsVersionCompatible(VersionA.s, VersionB.s)
	
EndProcedure

;}

;
;- Unit Tests & Examples
;{

; Insert some code here

;}

; IDE Options = PureBasic 5.60 (Windows - x86)
; CursorPosition = 28
; FirstLine = 134
; Folding = --
; EnableXP
; CompileSourceDirectory