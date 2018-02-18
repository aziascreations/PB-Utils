; ╔═════════════════════════════════════════════════════════╦════════╗
; ║ Purebasic Utils - Localizer                             ║ v0.0.2 ║
; ╠═════════════════════════════════════════════════════════╩════════╣
; ║                                                                  ║
; ║   ???                                                            ║
; ║                                                                  ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Requirements: * PB v5.60+ (Not tested onprevious versions)       ║
; ║               * Previous versions are untested                   ║
; ╚══════════════════════════════════════════════════════════════════╝

; TODO: Check if ClearStructure must be used when loading languages over and over.
; http://www.purebasic.fr/english/viewtopic.php?f=7&t=41990
; Might not be needed, will do tests later.

; TODO: Check if the jarek?'s way of doing it is better or if lists and maps work too.

; TODO: Clear old entries and groups when calling LoadLanguage() more than 1 time.

; TODO: in Localize(), if dotted mode is on and no key if given, attempt to get one from Group$.

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
	#LOADING_MODE_JSON ; Not fully implemented
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

; Returns a non-zero value if everything went correctly, more info is given in the debugger otherwise.
Procedure.b LoadLanguage(FilePath$="", LocalizingMode.b=#LOCALIZING_MODE_GROUPED, LoadingMode.b=#LOADING_MODE_SEPARATED)
	; Checking if at least one localizing mode is given
	If Not (LocalizingMode & #LOCALIZING_MODE_GROUPED Or LocalizingMode & #LOCALIZING_MODE_DOTTED)
		DebuggerError("The localizing mode is invalid. (loc-0.0)")
		ProcedureReturn #False
	EndIf
	
	; Checking if at least one loading mode is given
	If Not (LoadingMode & #LOADING_MODE_SEPARATED Or LoadingMode & #LOADING_MODE_JOINED)
		DebuggerError("The loading mode is invalid. (loc-0.1)")
		ProcedureReturn #False
	EndIf
	
	If LocalizingMode & #LOCALIZING_MODE_DOTTED And LoadingMode & #LOADING_MODE_NONULLGROUP
		DebuggerError("You can't use  the dotted and no-null modes at the same time. (loc-0.2)")
		ProcedureReturn #False
	EndIf
	
	If LocalizerOptions
		; Clean stuff ?
		; See 1st/2nd TODO at beginning of file.
		; Remove old entries and groups
	EndIf
	
	; Setting variables
	LocalizerOptions = LocalizingMode | LoadingMode
	Protected Group$, Key$, Value$, Temp$
	Protected GroupIndex.i = 0
	
	; Loading non-json DataSection stuff
	Restore Language
	
	Repeat
		Read.s Temp$
		
		; Cleaning the string
		Temp$ = Trim(Temp$)
		
		; Exiting loop if loading from json, done here to avoid "over-indentation" and to have some stuff already done.
		If LocalizerOptions & #LOADING_MODE_JSON Or Temp$ = #LOCALIZER_DATASECTION_END
			Break
		EndIf
		
		If Temp$ = #Null$
			Continue
		EndIf
		
		; Checking what the string is and doing stuff with it.
		Select Left(Temp$, 1)
			Case "#"
			Case "_"
				Continue
			Case "["
				If LocalizerOptions & #LOCALIZING_MODE_GROUPED
					Group$ = LTrim(RTrim(Temp$, "]"), "[")
					GetLanguageGroupIndex(Group$)
				EndIf
				Continue
			Default
				; Just checking if the Group$ variable is defined and if not, a group will
				;  be created, or -1 will be returned if the correct flag was set.
				If Group$ = #Null$
					If LocalizerOptions & #LOADING_MODE_NONULLGROUP
						DebuggerWarning("A null group was used to register an entry. (loc-1.0)")
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
				
				; Getting the group from the key if using the dotted notation.
				If LocalizerOptions & #LOCALIZING_MODE_DOTTED And FindString(Key$, ".")
					; Searching for the last dot in the key, if any, to divide the Group and key.
					Protected LastDotPosition.b = 1
					Repeat
						Protected _TmpIndex.b = FindString(Key$, ".", LastDotPosition)
						If LastDotPosition <> _TmpIndex
							LastDotPosition = _TmpIndex
						Else
							Break
						EndIf
					ForEver
					
					Group$ = Trim(Left(Key$, LastDotPosition-1))
					Key$ = Trim(Right(Key$, Len(Key$) - LastDotPosition))
					
					If LanguageGroups()\GroupName$ <> Group$
						If GetLanguageGroupIndex(Group$) = -1
							DebuggerWarning("error, too lazy. (loc-1.1)")
							ProcedureReturn #False
						EndIf
					EndIf
				EndIf
				
				If Key$ = #Null$
					DebuggerWarning("An entry key was null. (loc-1.2)")
					ProcedureReturn #False
				EndIf
				
				; Saving the entry
				LanguageGroups()\LocalizedStrings(Key$) = Value$
		EndSelect
	ForEver
	
	; Loading Json from DataSection
	If LocalizerOptions & #LOADING_MODE_JSON
		Debug "unimplemented !"
	EndIf
	
	; Preparing the FilePath$ variable
	; Return here if invalid file or no file at all
	If Not FileSize(FilePath$) >= 0
		ProcedureReturn #True
	EndIf
	
	
	
	; Loading non-json from file
	
	
	; Loading Json from file
	
	ProcedureReturn #True
EndProcedure

; Returns the localized String or FallBackValue$ in case of an error.
Procedure.s Localize(Group$="", Key$="", FallBackValue$=#LOCALIZER_ERROR_STRING)
	If Not LocalizerOptions
		; Error, nothing has been loaded
		ProcedureReturn #Null$
	EndIf
	
	If LanguageGroups()\GroupName$ <> Group$
		GetLanguageGroupIndex(Group$)
	EndIf
	
	
EndProcedure

; Prints the content of LanguageGroups() in the debugger.
Procedure DebugLocalizer()
	Debug "LanguageGroups() Dump:"
	
	ResetList(LanguageGroups())
	While NextElement(LanguageGroups())
		Debug "> (" + ListIndex(LanguageGroups()) + ") - "+ LanguageGroups()\GroupName$
		
		ForEach LanguageGroups()\LocalizedStrings()
			Debug "  "+MapKey(LanguageGroups()\LocalizedStrings()) + " -> "+  LanguageGroups()\LocalizedStrings(MapKey(LanguageGroups()\LocalizedStrings()))
		Next
	Wend
EndProcedure

;}

;LoadLanguage("", #LOCALIZING_MODE_GROUPED, #LOADING_MODE_JOINED)
LoadLanguage("", #LOCALIZING_MODE_DOTTED, #LOADING_MODE_JOINED)

DebugLocalizer()

DataSection
	;Language:
	Data$ "default = stuff"
	Data$ "[Test1]"
	Data$ "hello = world"
	Data$ "123 = numbers"
	Data$ #LOCALIZER_DATASECTION_END
	
	Language:
	Data$ "cat1.abc = hello"
	Data$ "cat1.def = world"
	Data$ "cat2.1 = abc"
	Data$ "cat3.1 = abc"
	Data$ "cat4.0 = abc"
	Data$ "[Test1]"
	Data$ ".hello = world"
	Data$ "123 = numbers"
	Data$ "group.key = content"
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
; CursorPosition = 7
; Folding = 4+
; EnableXP
; CompileSourceDirectory
; EnableCompileCount = 44
; EnableBuildCount = 0