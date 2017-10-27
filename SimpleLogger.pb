; ╔═════════════════════════════════════════════════════════╦════════╗
; ║ Purebasic Utils - Simple Logger                         ║ v0.0.1 ║
; ╠═════════════════════════════════════════════════════════╩════════╣
; ║                                                                  ║
; ║   It's just a test, so stuff might still not work.               ║
; ║                                                                  ║
; ╟──────────────────────────────────────────────────────────────────╢
; ║ Requirements: PB v5.60+ (Not tested with previous versions)      ║
; ╚══════════════════════════════════════════════════════════════════╝

;
;- Constants & Enums
;

Enumeration
	#LoggingLevel_Any =   %00111111
	#LoggingLevel_Trace = %01100000
	#LoggingLevel_Debug = %00100000
	
	#LoggingLevel_Fatal = %00001000
	#LoggingLevel_Error = %00000100
	#LoggingLevel_Warn =  %00000010
	#LoggingLevel_Info =  %00000001
	
; 	#LoggingLevel_DFatal = #LoggingLevel_Fatal & #LoggingLevel_Debug
; 	#LoggingLevel_DError = #LoggingLevel_Error & #LoggingLevel_Debug
; 	#LoggingLevel_DWarn = #LoggingLevel_Warn & #LoggingLevel_Debug
; 	#LoggingLevel_DInfo = #LoggingLevel_Info & #LoggingLevel_Debug
	
	#LoggingLevel_Off =   %00000000
	#LoggingLevel_Keep =  %10000000
EndEnumeration

Global _LogLevelConsole.b = #LoggingLevel_Off
Global _LogLevelDebug.b = #LoggingLevel_Any
Global _LogLevelFile.b = #LoggingLevel_Off

Global _FormatTime.s = "%yy-%mm-%dd %hh:%ii:%ss"
Global _FormatDebug.s = "%msg%"
Global _FormatFile.s = "%time% - %msg%"
Global _FormatConsole.s = "%msg%"

Global _LogPath.s = ""
Global _IsFileValid.b = #False


;
;- Config Procedures
;

; Returns: Nonzero if the operation was successful and if the new file, if given, is valid.
Procedure ConfigureLoggerOutputPath(LogFilePath.s="", KeepPreviousIfError.b=#True)
	If Not Len(LogFilePath)
		_LogPath = LogFilePath
		_IsFileValid = #False
		ProcedureReturn #True
	EndIf
	
	If Not KeepPreviousIfError
		_LogPath = LogFilePath
		_IsFileValid = #False
	EndIf
	
	If FileSize(LogFilePath) = -2
		Debug "Error: "+LogFilePath+" is a directory."
		ProcedureReturn #False
	EndIf
	
	If FileSize(LogFilePath) >= 0
		Debug "Warn: "+LogFilePath+" already exist, some data could be corrupted if not carefull."
	EndIf
	
	_LogPath = LogFilePath
	_IsFileValid = #True
	ProcedureReturn #True
EndProcedure

Procedure ConfigureLoggerLevels(LogFileLoggingLevel.b=#LoggingLevel_Keep, DebugWindowLoggingLevel.b = #LoggingLevel_Keep, ConsoleLoggingLevel.b = #LoggingLevel_Keep)
	If Not LogFileLoggingLevel & #LoggingLevel_Keep
		_LogLevelFile = LogFileLoggingLevel
	EndIf
	
	If Not DebugWindowLoggingLevel & #LoggingLevel_Keep
		_LogLevelDebug = DebugWindowLoggingLevel
	EndIf
	
	If Not ConsoleLoggingLevel & #LoggingLevel_Keep
		_LogLevelConsole = ConsoleLoggingLevel
	EndIf
EndProcedure

Procedure ConfigureLoggerFormat(TimeFormat.s="", DebugWindowLoggingFormat.s="", LogFileLoggingFormat.s="", ConsoleLoggingFormat.s="")
	If Len(TimeFormat)
		_FormatTime = TimeFormat
	EndIf
	
	If Len(DebugWindowLoggingFormat)
		_FormatDebug = DebugWindowLoggingFormat
	EndIf
	
	If Len(LogFileLoggingFormat)
		_FormatFile = LogFileLoggingFormat
	EndIf
	
	If Len(ConsoleLoggingFormat)
		_FormatConsole = ConsoleLoggingFormat
	EndIf
EndProcedure


;
;- Logging Procedures
;

Procedure.s _FormatLogString(_Format.s, _Message.s)
	_Format = ReplaceString(_Format, "%time%", FormatDate(_FormatTime, Date()))
	_Message = ReplaceString(_Format, "%msg%", _Message)
	ProcedureReturn _Message
EndProcedure

Procedure _Log(MessageLevel.b, Message.s, OpenMB.b, Title.s, MBMessage.s, MBFlags)
	If _LogLevelDebug & MessageLevel
		Debug _FormatLogString(_FormatDebug, Message)
	EndIf
	
	If _LogLevelConsole & MessageLevel
		PrintN(_FormatLogString(_FormatConsole, Message))
	EndIf
	
EndProcedure

Procedure LogDebug(Message.s, OpenMB.b=#False, Title.s="Debug...", MBMessage.s="Why is this even shown ?!?", MBFlags=#PB_MessageRequester_Info)
	ProcedureReturn _Log(#LoggingLevel_Debug, Message, OpenMB, Title, MBMessage, MBFlags)
EndProcedure

Procedure LogFatal(Message.s, ExitCode.i=-1, OpenMB.b=#False, Title.s="Fatal Error", MBMessage.s="A fatal error has occured.", MBFlags=#PB_MessageRequester_Error)
	Protected a = _Log(#LoggingLevel_Fatal, Message, OpenMB, Title, MBMessage, MBFlags)
	If ExitCode = -1
		ProcedureReturn a
	Else
		End ExitCode
	EndIf
EndProcedure

Procedure LogError(Message.s, OpenMB.b=#False, Title.s="Error", MBMessage.s="An error has occured.", MBFlags=#PB_MessageRequester_Error)
	ProcedureReturn _Log(#LoggingLevel_Error, Message, OpenMB, Title, MBMessage, MBFlags)
EndProcedure

Procedure LogWarn(Message.s, OpenMB.b=#False, Title.s="Warning", MBMessage.s="A warning has been issued.", MBFlags=#PB_MessageRequester_Warning)
	ProcedureReturn _Log(#LoggingLevel_Warn, Message, OpenMB, Title, MBMessage, MBFlags)
EndProcedure

Procedure LogInfo(Message.s, OpenMB.b=#False, Title.s="Info", MBMessage.s="Do you really need to bother the user with basic info ?", MBFlags=#PB_MessageRequester_Info)
	ProcedureReturn _Log(#LoggingLevel_Info, Message, OpenMB, Title, MBMessage, MBFlags)
EndProcedure


;
;- Tests & Examples
;

CompilerIf #PB_Compiler_IsMainFile
	; TODO: Add an example here
CompilerEndIf

; IDE Options = PureBasic 5.60 (Windows - x86)
; Folding = --
; EnableXP
; CompileSourceDirectory