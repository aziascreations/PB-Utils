; ╔═════════════════════════════════════════════════════════╦════════╗
; ║ Purebasic Utils - Localizer                             ║ v0.0.1 ║
; ╠═════════════════════════════════════════════════════════╩════════╣
; ║                                                                  ║
; ║   ???                                                            ║
; ║                                                                  ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Requirements: * PB v5.60+ Or V5.4x+ LTS                          ║
; ║               * Previous versions are untested                   ║
; ╚══════════════════════════════════════════════════════════════════╝

; TODO: Check if ClearStructure can be used when loading languages over and over
; http://www.purebasic.fr/english/viewtopic.php?f=7&t=41990
; Might not be needed, will do tests later.

; TODO: Check if the jarek?'s way of doing it is better or if lists and maps work too.

; TODO; Implement a check for empty key for parsing

; TODO: Clean the path before loading a custom lang file

;
;- Compiler Options
;{

; The following line is only use to see if it works with it and for debugging
;EnableExplicit

;}

;
;- Variables, Structures & Constants
;{

EnumerationBinary LocalizerOptions
	#LOCALIZING_MODE_GROUPED
	#LOCALIZING_MODE_DOTTED
	#LOADING_MODE_SEPARATED
	#LOADING_MODE_JOINED
	#LOADING_MODE_NONULLGROUP
	; #LOADING_MODE_JSON ; Might be added later (Will require a lot more work than the other ones)
EndEnumeration

Structure LanguageGroup
	GroupName$
	Map LocalizedStrings.s()
EndStructure

#LOCALIZER_DATASECTION_END = "_END_"
#LOCALIZER_ERROR_STRING = "!!ERROR_UNREGISTRED_ENTRY!!"
#LOCALIZER_DEFAULT_GROUP = "_DEFAULT_"

; Used to store the given parameters in the LoadLanguage() procedure
Global LocalizerOptions.b = 0

Global NewList LanguageGroups.LanguageGroup()

;}

;
;- Procedures
;{

; Returns: * The group index in LanguageGroups(), and if the group isn't found and CreateIfNotFound.b is #True, it will be created.
;          * -1 if GroupName$ = #Null$ and #LOADING_MODE_NONULLGROUP was given in LoadLanguage().
; The corresponding list element will also be selected is something else than -1 was returned.
Procedure.b GetLanguageGroupIndex(GroupName$, CreateIfNotFound.b=#False)
	; Checking if Group is #Null$ to either return -1 or use the default group.
	If Trim(GroupName$) = #Null$
		If LocalizerOptions & #LOADING_MODE_NONULLGROUP
			ProcedureReturn -1
		EndIf
		
		GroupName$ = #LOCALIZER_DEFAULT_GROUP
	EndIf
	
	; Checking if the given ground is already registered ad returning the index if it is.
	ResetList(LanguageGroups())
	While NextElement(LanguageGroups())
		If LanguageGroups()\GroupName$ = GroupName$
			ProcedureReturn ListIndex(LanguageGroups())
		EndIf
	Wend
	
	; Creating new group and returning it's index number.
	AddElement(LanguageGroups())
	LanguageGroups()\GroupName$ = GroupName$
	
	ProcedureReturn ListIndex(LanguageGroups())
EndProcedure

; Returns a non-zero value if everything went correctly, otherwise, more info is give in the debugger.
Procedure.b LoadLanguage(Filename$="", LocalizingMode.b=#LOCALIZING_MODE_GROUPED, LoadingMode.b=#LOADING_MODE_SEPARATED)
	; Checking if at least one localizing mode is given
	If Not (LocalizingMode & #LOCALIZING_MODE_GROUPED Or LocalizingMode & #LOCALIZING_MODE_DOTTED)
		DebuggerError("The localizing mode is invalid. (ref: loc.deb-0.0)")
		ProcedureReturn #False
	EndIf
	
	; Checking if at least one loading mode is given
	If Not (LoadingMode & #LOADING_MODE_SEPARATED Or LoadingMode & #LOADING_MODE_JOINED)
		DebuggerError("The loading mode is invalid. (ref: loc.deb-0.1)")
		ProcedureReturn #False
	EndIf
	
	If LocalizingMode & #LOCALIZING_MODE_DOTTED And LoadingMode & #LOADING_MODE_NONULLGROUP
		DebuggerError("You can't use  the dotted and no-null modes at the same time. (ref: loc.deb-0.2)")
		ProcedureReturn #False
	EndIf
	
	If LocalizerOptions
		; Clean stuff ?
		; See 1st/2nd TODO at beginning of file.
	EndIf
	
	; Setting variables
	LocalizerOptions = LocalizingMode | LoadingMode
	Protected Group$, Key$, Value$, Temp$
	Protected GroupIndex.i = 0
	
	; Load-old
	; 	If LocalizerOptions & #LOADING_MODE_JSON
	; 		; Json parsing
	; 	Else
	; 		; Non-json
	; 	EndIf
	
	; Loading DataSection stuff
	Restore Language
	
	Repeat
		Read.s Temp$
		
		; Cleaning the string
		Temp$ = Trim(Temp$)
		
		If Not Len(Temp$)
			Continue
		EndIf
		
		If Temp$ = #LOCALIZER_DATASECTION_END
			;Debug "Ending"
			Break
		EndIf
		
		; Put the # dectection here ?
		
		; Checking what the string is
		
		; This check will only be done is specific parts since the dotted method only
		;  registers stuff in the #Null$ group.
		; BTW, you used a loc. const, not the load. one, dumbass...
		;If LocalizerOptions & #LOCALIZING_MODE_GROUPED
		Select Left(Temp$, 1)
			Case "#"
			Case "_"
				; Will cause more troubles than it solves...
				;If LocalizerOptions & #LOADING_MODE_SEPARATED
				;	Read.s Temp$ ; Skip
				;EndIf
				
				Continue
			Case "["
				Group$ = LTrim(RTrim(Temp$, "]"), "[")
				GetLanguageGroupIndex(Group$)
				Continue
				;Break
			Default
				; Just checking if the Group$ variable is defined and if not, a group will
				;  be created, or -1 will be returned if the correct flag was set.
				If Group$ = #Null$
					If LocalizerOptions & #LOADING_MODE_NONULLGROUP
						DebuggerWarning("A null group was used to register an entry. (ref: loc.deb-1.0)")
						ProcedureReturn #False
					EndIf
					
					; "Defining" Group$ and creating a group to avoid writing stuff in an empty list.
					Group$ = #LOCALIZER_DEFAULT_GROUP
					GetLanguageGroupIndex(Group$)
				EndIf
				
				; "Parsing" the entry
				If LocalizerOptions & #LOADING_MODE_JOINED
					Key$ = Trim(Left(Temp$, FindString(Temp$, "=")-1))
					Value$ = Trim(Right(Temp$, Len(Temp$) - FindString(Temp$, "=")))
				Else ; #LOADING_MODE_SEPARATED implied
					Key$ = Temp$
					Read.s Value$
				EndIf
				
				; Saving the entry
				LanguageGroups()\LocalizedStrings(Key$) = Value$
				;Debug ">> " + Key$ + " -> " + Value$
		EndSelect
		
		; 		ElseIf LocalizerOptions & #LOCALIZING_MODE_DOTTED
		; 			
		; 		Else
		; 			Debug "This is reserved for json, maybe ?"
		; 			End 1
		; 		EndIf
		
	ForEver
	
	ProcedureReturn #True
EndProcedure


; Returns: The localized String or #ERRSTRING in case of an error
Procedure.s Localize(Group$="", Name$="", FallBackValue$=#LOCALIZER_ERROR_STRING)
	If Not LocalizerOptions
		; Error, nothing has been loaded
		ProcedureReturn #Null$
	EndIf
	
	If LanguageGroups()\GroupName$ <> Group$
		GetLanguageGroupIndex(Group$)
	EndIf
	
	
EndProcedure

Procedure DebugLocalizer()
	Debug "LanguageGroups() Dump:"
	
	ResetList(LanguageGroups())
	While NextElement(LanguageGroups())
		Debug "> " + LanguageGroups()\GroupName$ + " (" + ListIndex(LanguageGroups()) + ")"
		
		ForEach LanguageGroups()\LocalizedStrings()
			Debug "  "+MapKey(LanguageGroups()\LocalizedStrings()) + " -> "+  LanguageGroups()\LocalizedStrings(MapKey(LanguageGroups()\LocalizedStrings()))
		Next
	Wend
EndProcedure

;}

LoadLanguage("", #LOCALIZING_MODE_GROUPED, #LOADING_MODE_JOINED)

DebugLocalizer()

DataSection
	Language:
	
	Data$ "default = stuff"
	
	Data$ "[Test1]"
	Data$ "hello = world"
	Data$ "123 = numbers"
	Data$ #LOCALIZER_DATASECTION_END
	
	;Language:
	Data$ "group.key = content"
	; Add more poorly formatted stuff
	Data$ #LOCALIZER_DATASECTION_END
	
EndDataSection



;
;- Unit Tests & Examples
;{

; CompilerIf #PB_Compiler_IsMainFile
; 	XIncludeFile "UnitTest-Basic.pb"
; 	
; 	Debug "Unit tests -> "+Chr(34)+#PB_Compiler_Filename+Chr(34)
; 	Debug ""
; 	
; 	Debug "> Unk()"
; 	Debug ""
; 	
; 	Debug "-- "+PassedUnitTests+" passed - "+FailedUnitTests+" failed --"
; CompilerEndIf

;}

; IDE Options = PureBasic 5.60 (Windows - x86)
; CursorPosition = 152
; FirstLine = 141
; Folding = --
; EnableXP
; CompileSourceDirectory
; EnableCompileCount = 28
; EnableBuildCount = 0