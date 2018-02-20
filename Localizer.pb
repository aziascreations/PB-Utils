; ╔═══════════════════════════════════════════════════════════════════╦════════╗
; ║ Purebasic Utils - Localizer                                       ║ v0.0.4 ║
; ╠═══════════════════════════════════════════════════════════════════╩════════╣
; ║                                                                            ║
; ║   ???                                                                      ║
; ║                                                                            ║
; ╟────────────────────────────────────────────────────────────────────────────╢
; ║ Requirements: PB v5.60+ (Not tested on previous versions)                  ║
; ╟────────────────────────────────────────────────────────────────────────────╢
; ║ Documentation: https://github.com/aziascreations/PB-Utils/wiki/Localizer   ║
; ╚════════════════════════════════════════════════════════════════════════════╝

; TODO: Check if ClearStructure must be used when loading languages over and over.
; http://www.purebasic.fr/english/viewtopic.php?f=7&t=41990
; Might not be needed, will do tests later.

; TODO: Check if the jarek?'s way of doing it is better or if lists and maps work too.

; TODO: Clear old entries and groups when calling LoadLanguage() more than 1 time.

; TODO: in Localize(), if dotted mode is on and no key if given, attempt to get one from Group$.

; Put a special comment in the readme about how this utility is still unoptimized and that major changes will occur later.

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
	#LOADING_MODE_JSON
EndEnumeration

Structure LanguageGroup
	GroupName$
	Map LocalizedStrings.s()
EndStructure

#LOCALIZER_DATASECTION_END = "_END_"
#LOCALIZER_ERROR_STRING = "!!ERROR_UNREGISTRED_ENTRY!!"
#LOCALIZER_DEFAULT_GROUP = "_DEFAULT_"

; Might change the constant to this later, will require some change depending on the implementation.
;Global LocalizerErrorString$ = "!!ERROR_UNREGISTRED_ENTRY!!"

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
	;- > Checking, cleaning and setting variables
	;{
	
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
	
	; Values used inside the big loops, couldn't use protected for both because fuck variable scope right ?, fucking hell...
	Protected LastDotPosition.b = 0
	Protected _TmpIndex.b
	
	; Value used in the second lood (Replace Temp$ with this one later ?)
	Protected Line$
	; Same for these ones except the json, it is used after the 1st one if using json.
	Protected FileId.i, JsonId.i
	
	;}
	;- > ???
	;{
	
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
					LastDotPosition = 1
					Repeat
						_TmpIndex = FindString(Key$, ".", LastDotPosition)
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
		DebuggerWarning("unimplemented !")
	EndIf
	
	;}
	;- > Preparing & loading locale file
	;{
	
	; Returns if the file can't be loaded.
	If Not FileSize(FilePath$) >= 0
		ProcedureReturn #True
	EndIf
	
	If LocalizerOptions & #LOADING_MODE_JSON
		JsonId = LoadJSON(#PB_Any, FilePath$)
		If Not JsonId
			DebuggerWarning("Failed to open/parse given json locale file: " + FilePath$)
			DebuggerWarning(JSONErrorMessage()+" - L"+JSONErrorLine()+":"+JSONErrorPosition())
			ProcedureReturn #False
		EndIf
	Else
		FileId = ReadFile(#PB_Any, FilePath$)
		If Not FileId
			DebuggerWarning("Failed to open given locale file: " + FilePath$)
			ProcedureReturn #False
		EndIf
	EndIf
	
	;}
	;- > Parsing locale file data
	;{
	
	Group$ = #Null$
	
	If LocalizerOptions & #LOADING_MODE_JSON
		; Loading Json from file
		
		; TODO: Insert stuff here
		
		FreeJSON(JsonId)
	Else
		; Loading non-json from file
		
		; This whole loop is more or less the same as the one above except for some
		;  instructions that were removed since the DataSection is no longer used at this point.
		While Not Eof(FileId)
			Line$ = Trim(ReadString(FileId))
			
			If Line$ = #Null$
				Continue
			EndIf
			
			Select Left(Line$, 1)
				Case "#"
				Case "_"
					Continue
				Case "["
					If LocalizerOptions & #LOCALIZING_MODE_GROUPED
						Group$ = LTrim(RTrim(Line$, "]"), "[")
						GetLanguageGroupIndex(Group$)
					EndIf
					Continue
				Default
					; Just checking if the Group$ variable is defined and if not, a group will
					;  be created, or -1 will be returned if the correct flag was set.
					If Group$ = #Null$
						If LocalizerOptions & #LOADING_MODE_NONULLGROUP
							DebuggerWarning("A null group was used to register an entry. (loc-?.? second loop)")
							ProcedureReturn #False
						EndIf
						
						; "Defining" Group$ and creating a group to avoid writing stuff in an empty list.
						Group$ = #LOCALIZER_DEFAULT_GROUP
						GetLanguageGroupIndex(Group$)
					EndIf
					
					; "Parsing" the entry
					Key$ = Trim(Left(Line$, FindString(Line$, "=")-1))
					Value$ = Trim(Right(Line$, Len(Line$) - FindString(Line$, "=")))
					
					; Getting the group from the key if using the dotted notation.
					If LocalizerOptions & #LOCALIZING_MODE_DOTTED And FindString(Key$, ".")
						; Searching for the last dot in the key, if any, to divide the Group and key.
						LastDotPosition.b = 1
						Repeat
							_TmpIndex = FindString(Key$, ".", LastDotPosition)
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
								DebuggerWarning("error, too lazy. (loc-1.1 SL)")
								ProcedureReturn #False
							EndIf
						EndIf
					EndIf
					
					If Key$ = #Null$
						DebuggerWarning("An entry key was null. (loc-1.2 SL)")
						ProcedureReturn #False
					EndIf
					
					; Saving the entry
					LanguageGroups()\LocalizedStrings(Key$) = Value$
			EndSelect
		Wend
		
		CloseFile(FileId)
	EndIf
	
	;}
	
	ProcedureReturn #True
EndProcedure

; Returns the localized String or FallBackValue$ in case of an error.
Procedure.s Localize(Group$="", Key$="", FallBackValue$=#LOCALIZER_ERROR_STRING)
	If Not LocalizerOptions
		DebuggerWarning("An attempt to localize a string before succesfully calling LoadLanguage() was made, returning the fallback value.")
		ProcedureReturn FallBackValue$
	EndIf
	
	If Key$ = #Null$
		DebuggerWarning("A null value was used in Localize()'s Key$ parameter, returning the fallback value.")
		ProcedureReturn FallBackValue$
	EndIf
	
	If LanguageGroups()\GroupName$ <> Group$
		GetLanguageGroupIndex(Group$)
	EndIf
	
	Protected LocalizedString$ = LanguageGroups()\LocalizedStrings(Key$)
	
	If LocalizedString$ = #Null$
		ProcedureReturn FallBackValue$
	EndIf
	
	ProcedureReturn LocalizedString$
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

;Procedure SaveCurrentLocale(FilePath$, Overwrite.b=#False)

;}

LoadLanguage("./locales/test1.txt", #LOCALIZING_MODE_GROUPED, #LOADING_MODE_JOINED)
;LoadLanguage("./locales/test1.txt", #LOCALIZING_MODE_DOTTED, #LOADING_MODE_JOINED)
Debug ""
DebugLocalizer()
Debug ""

Debug Localize("Test1", "hello")
Debug Localize(#Null$, "default")
Debug Localize("Test1", #Null$)

DataSection
	Language:
	Data$ "default = stuff"
	Data$ "[Test1]"
	Data$ "hello = world"
	Data$ "123 = numbers"
	Data$ #LOCALIZER_DATASECTION_END
	
	;Language:
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
; CursorPosition = 136
; FirstLine = 123
; Folding = ---
; EnableXP
; CompileSourceDirectory
; EnableCompileCount = 57
; EnableBuildCount = 0