
Structure CommitChangelog
	List additions.s()
	List modifications.s()
	List fixes.s()
	List deprecations.s()
	List deletions.s()
	List security.s()
	List misc.s()
EndStructure

Structure Commit
	commit.s
	date.s
	changelog.CommitChangelog
EndStructure

Structure Version
	desc.s
	isReleased.b
	List commits.Commit()
EndStructure

Structure Util
	filename.s
	isExperimental.b
	isReleased.b
	
	Map versions.Version()
EndStructure

Structure Changelog
	Map utilities.Util()
EndStructure


;=======================

#CHANGELOG_FILE$ = "./changelog.json"
#SC = 2

Global Changelog.Changelog


;=======================

Debug "Loading and extracting JSON structure..."
If LoadJSON(0, #CHANGELOG_FILE$, #PB_JSON_NoCase)
	ExtractJSONStructure(JSONValue(0), @Changelog, Changelog)
	FreeJSON(0)
Else
	Debug "Fatal JSON error:"
	Debug "> " + JSONErrorMessage()+" @"+JSONErrorLine()+":"+JSONErrorPosition() 
	
	End 1
EndIf
Debug ""


;=======================

Debug "Checking and dumping structure..."
Debug "Found "+Str(MapSize(Changelog\Utilities())) + " utilities in the changelog"

ForEach Changelog\Utilities()
	Debug "> "+MapKey(Changelog\Utilities())
	
	Debug Space(#SC*1) + "> Filename:       "+Changelog\Utilities()\filename
	Debug Space(#SC*1) + "> isExperimental: "+Changelog\Utilities()\isExperimental
	Debug Space(#SC*1) + "> isReleased:     "+Changelog\Utilities()\isReleased
	Debug Space(#SC*1) + "> Versions ("+MapSize(Changelog\Utilities()\versions())+")"
	
	ForEach Changelog\Utilities()\versions()
		Debug Space(#SC*2) + "> "+MapKey(Changelog\Utilities()\versions())
		
		Continue
		
		With Changelog\Utilities()\versions()
			Debug Space(#SC*3) + "> Description: " + \desc
			Debug Space(#SC*3) + "> isReleased:  " + \isReleased
			Debug Space(#SC*3) + "> Commits ("+ListSize(\commits())+")"
			
			ForEach \commits()
				Debug Space(#SC*4) + "> "+\commits()\commit
				
				Debug Space(#SC*5) + "> Date: "+\commits()\date
				
				Debug Space(#SC*5) + "> Additions ("+ListSize(\commits()\changelog\additions())+")"
				ForEach \commits()\changelog\additions()
					Debug Space(#SC*6) + "> "+\commits()\changelog\additions()
				Next
				
				Debug Space(#SC*5) + "> Modifications ("+ListSize(\commits()\changelog\modifications())+")"
				ForEach \commits()\changelog\modifications()
					Debug Space(#SC*6) + "> "+\commits()\changelog\modifications()
				Next
				
				Debug Space(#SC*5) + "> Fixes ("+ListSize(\commits()\changelog\fixes())+")"
				ForEach \commits()\changelog\fixes()
					Debug Space(#SC*6) + "> "+\commits()\changelog\fixes()
				Next
				
				Debug Space(#SC*5) + "> Deletions ("+ListSize(\commits()\changelog\deletions())+")"
				ForEach \commits()\changelog\deletions()
					Debug Space(#SC*6) + "> "+\commits()\changelog\deletions()
				Next
				
				Debug Space(#SC*5) + "> Deprecations ("+ListSize(\commits()\changelog\deprecations())+")"
				ForEach \commits()\changelog\deprecations()
					Debug Space(#SC*6) + "> "+\commits()\changelog\deprecations()
				Next
				
				Debug Space(#SC*5) + "> Security ("+ListSize(\commits()\changelog\security())+")"
				ForEach \commits()\changelog\security()
					Debug Space(#SC*6) + "> "+\commits()\changelog\security()
				Next
				
			Next
		EndWith
	Next
	Debug ""
Next


;=======================

Debug "Generating changelog text..."
ChangelogText$ = ""
ChangelogText$ = "# Changelog"+#CRLF$

NewList MapKeys.s()

ForEach Changelog\utilities()
	AddElement(MapKeys())
	MapKeys() = MapKey(Changelog\utilities())
Next

SortList(MapKeys(), #PB_Sort_NoCase | #PB_Sort_Ascending)

ChangelogText$ + "## Summary" + #CRLF$

ForEach MapKeys()
	If Changelog\utilities(MapKeys())\isExperimental
		ChangelogText$ + "&emsp;●&nbsp;&nbsp;" + "["+MapKeys()+"](#"+LCase(MapKeys())+"-experimental"+")<br>"+#CRLF$
	Else
		ChangelogText$ + "&emsp;●&nbsp;&nbsp;" + "["+MapKeys()+"](#"+LCase(MapKeys())+")<br>"+#CRLF$
	EndIf
Next
ChangelogText$ + "<br>"+#CRLF$


ForEach MapKeys()
	FindMapElement(Changelog\utilities(), MapKeys())
	
	If Changelog\utilities()\isExperimental
		ChangelogText$ + "## " + MapKeys() + " <sub><sup>(Experimental)</sup></sub>" + #CRLF$
	Else
		ChangelogText$ + "## " + MapKeys() + #CRLF$
	EndIf
	
	With Changelog\utilities()
		NewList VersionKeys.s()
		
		ForEach \versions()
			AddElement(VersionKeys())
			VersionKeys() = MapKey(\versions())
		Next
		
		SortList(VersionKeys(), #PB_Sort_NoCase | #PB_Sort_Descending)
		
		ForEach VersionKeys()
			FindMapElement(\versions(), VersionKeys())
			
			If \versions()\desc <> #Null$
				ChangelogText$ + "### &emsp;" + VersionKeys() + " - <sub><sup>" +
				                 \versions()\desc + "</sup></sub>" + #CRLF$
				
				If \versions()\desc = "Initial Release"
					ChangelogText$ + "&emsp;&emsp;●&nbsp;&nbsp;" + "Initial Release"+"<br>" +  #CRLF$
					Continue
				EndIf
			Else
				ChangelogText$ + "### &emsp;" + VersionKeys() + #CRLF$
			EndIf
			
			; Sort commits with SortStructuredList()
			
			ForEach \versions()\commits()
				ForEach \versions()\commits()\changelog\additions()
					ChangelogText$ + "&emsp;&emsp;●&nbsp;&nbsp;" + \versions()\commits()\changelog\additions() + "<br>" +  #CRLF$
				Next
				ForEach \versions()\commits()\changelog\modifications()
					ChangelogText$ + "&emsp;&emsp;●&nbsp;&nbsp;" + \versions()\commits()\changelog\modifications() + "<br>" +  #CRLF$
				Next
				ForEach \versions()\commits()\changelog\deprecations()
					ChangelogText$ + "&emsp;&emsp;●&nbsp;&nbsp;" + \versions()\commits()\changelog\deprecations() + "<br>" +  #CRLF$
				Next
				ForEach \versions()\commits()\changelog\deletions()
					ChangelogText$ + "&emsp;&emsp;●&nbsp;&nbsp;" + \versions()\commits()\changelog\deletions() + "<br>" +  #CRLF$
				Next
				ForEach \versions()\commits()\changelog\fixes()
					ChangelogText$ + "&emsp;&emsp;●&nbsp;&nbsp;" + \versions()\commits()\changelog\fixes() + "<br>" +  #CRLF$
				Next
				ForEach \versions()\commits()\changelog\security()
					ChangelogText$ + "&emsp;&emsp;●&nbsp;&nbsp;" + \versions()\commits()\changelog\security() + "<br>" + #CRLF$
				Next
				ForEach \versions()\commits()\changelog\misc()
					ChangelogText$ + "&emsp;&emsp;●&nbsp;&nbsp;" + \versions()\commits()\changelog\misc() + "<br>" +  #CRLF$
				Next
			Next
		Next
		
		FreeList(VersionKeys())
		
		ChangelogText$+"<br>"+#CRLF$+#CRLF$
	EndWith
Next

FreeList(MapKeys())

;SortStructuredList(Changelog\utilities(), #PB_Sort_NoCase | #PB_Sort_Ascending, OffsetOf())

Debug ""


;=======================

Debug "Writing changelog file content..."
OutputPath$ = "changelog_"+FormatDate("%yyyy-%mm-%dd_%hh-%ii-%ss", Date())+".md"
OutputPath$ = "../changelog.md"
Debug "> "+OutputPath$

If Not DeleteFile(OutputPath$)
	Debug "Failed to delete old "+#DQUOTE$+OutputPath$+#DQUOTE$+" file !"
EndIf

If CreateFile(0, OutputPath$)
	WriteString(0, ChangelogText$, #PB_UTF8)
	CloseFile(0)
	Debug "Success !"
Else
	Debug "Failed to create file !"
	End 2
EndIf

Debug ""


;=======================

Debug "Done !"

End 0

; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 221
; FirstLine = 206
; EnableXP