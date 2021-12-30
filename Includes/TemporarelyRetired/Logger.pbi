;{- Code Header
; ==- Basic Info -================================
;         Name: Logger.pbi
;      Version: 1.0.0
;       Author: Herwin Bozet
;  Create date: 27 October 2017, 01:58:13
; 
;  Description: ???
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.62 (x64) (Other versions untested)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;  License: WTFPL
; 
;}

; TODO: Add option to enable/disable (override) fatal error MB thingy

; TODO: Change the Enumaration for the levels to a EnumerationBinary

;
;- Constants, Globals & Enums
;{

Enumeration
	#LoggingLevel_Any =   %00111111
	#LoggingLevel_Trace = %01000000
	#LoggingLevel_Debug = %00100000
	
	#LoggingLevel_Fatal = %00001000
	#LoggingLevel_Error = %00000100
	#LoggingLevel_Warn =  %00000010
	#LoggingLevel_Info =  %00000001
	
	#LoggingLevel_Off =   %00000000
	#LoggingLevel_Keep =  %10000000
EndEnumeration

Structure LoggerVariables
	LogLevelConsole.b
	LogLevelDebug.b
	LogLevelFile.b
	
	FormatTime.s
	FormatDebug.s
	FormatFile.s
	FormatConsole.s
	
	LogPath.s
	IsFileValid.b
EndStructure

Global LoggerConfig.LoggerVariables

With LoggerConfig
	\LogLevelConsole.b = #LoggingLevel_Off
	\LogLevelDebug.b = #LoggingLevel_Any
	\LogLevelFile.b = #LoggingLevel_Off
	
	\FormatTime = "%yy-%mm-%dd %hh:%ii:%ss"
	\FormatDebug = "%msg%"
	\FormatFile = "%time% - %msg%"
	\FormatConsole = "%msg%"
	
	\LogPath = ""
	\IsFileValid = #False
EndWith
;}

;
;- Config Procedures
;{

; Returns: Nonzero if the operation was successful and if the new file, if given, is valid.
Procedure ConfigureLoggerOutputPath(LogFilePath.s="", KeepPreviousIfError.b=#True)
	If Not Len(LogFilePath)
		LoggerConfig\LogPath = LogFilePath
		LoggerConfig\IsFileValid = #False
		ProcedureReturn #True
	EndIf
	
	If Not KeepPreviousIfError
		LoggerConfig\LogPath = LogFilePath
		LoggerConfig\IsFileValid = #False
	EndIf
	
	If FileSize(LogFilePath) = -2
		Debug "Error: "+LogFilePath+" is a directory."
		ProcedureReturn #False
	EndIf
	
	If FileSize(LogFilePath) >= 0
		Debug "Warn: "+LogFilePath+" already exist, some data could be corrupted if not carefull."
	EndIf
	
	LoggerConfig\LogPath = LogFilePath
	LoggerConfig\IsFileValid = #True
	ProcedureReturn #True
EndProcedure

Procedure ConfigureLogLevels(LogFileLoggingLevel.b=#LoggingLevel_Keep, DebugWindowLoggingLevel.b = #LoggingLevel_Keep, ConsoleLoggingLevel.b = #LoggingLevel_Keep)
	If Not LogFileLoggingLevel & #LoggingLevel_Keep
		LoggerConfig\LogLevelFile = LogFileLoggingLevel
	EndIf
	
	If Not DebugWindowLoggingLevel & #LoggingLevel_Keep
		LoggerConfig\LogLevelDebug = DebugWindowLoggingLevel
	EndIf
	
	If Not ConsoleLoggingLevel & #LoggingLevel_Keep
		LoggerConfig\LogLevelConsole = ConsoleLoggingLevel
	EndIf
EndProcedure

Procedure ConfigureFileLogLevel(LogFileLoggingLevel.b)
	ConfigureLogLevels(LogFileLoggingLevel, #LoggingLevel_Keep, #LoggingLevel_Keep)
EndProcedure

Procedure ConfigureDebugWindowLogLevel(DebugWindowLoggingLevel.b)
	ConfigureLogLevels(#LoggingLevel_Keep, DebugWindowLoggingLevel, #LoggingLevel_Keep)
EndProcedure

Procedure ConfigureConsoleLogLevel(ConsoleLoggingLevel.b)
	ConfigureLogLevels(#LoggingLevel_Keep, #LoggingLevel_Keep, ConsoleLoggingLevel)
EndProcedure

Procedure ConfigureLogFormats(TimeFormat.s="", DebugWindowLoggingFormat.s="", LogFileLoggingFormat.s="", ConsoleLoggingFormat.s="")
	If Len(TimeFormat)
		LoggerConfig\FormatTime = TimeFormat
	EndIf
	
	If Len(DebugWindowLoggingFormat)
		LoggerConfig\FormatDebug = DebugWindowLoggingFormat
	EndIf
	
	If Len(LogFileLoggingFormat)
		LoggerConfig\FormatFile = LogFileLoggingFormat
	EndIf
	
	If Len(ConsoleLoggingFormat)
		LoggerConfig\FormatConsole = ConsoleLoggingFormat
	EndIf
EndProcedure

Procedure ConfigureTimeLogFormat(TimeFormat.s)
	ConfigureLogFormats(TimeFormat, "", "", "")
EndProcedure

Procedure ConfigureDebugWindowLogFormat(DebugWindowLoggingFormat.s)
	ConfigureLogFormats("", DebugWindowLoggingFormat, "", "")
EndProcedure

Procedure ConfigureFileLogFormat(LogFileLoggingFormat.s)
	ConfigureLogFormats("", "", LogFileLoggingFormat, "")
EndProcedure

Procedure ConfigureConsoleLogFormat(ConsoleLoggingFormat.s)
	ConfigureLogFormats("", "", "", ConsoleLoggingFormat)
EndProcedure
;}

;
;- Logging Procedures
;{

Procedure.s _FormatLogString(_Format.s, _Message.s, _MBTitle.s, _MBMessage.s)
	_Format = ReplaceString(_Format, "%time%", FormatDate(LoggerConfig\FormatTime, Date()))
	_Message = ReplaceString(_Format, "%msg%", _Message)
	_Message = ReplaceString(_Message, "%mbtitle%", _MBTitle)
	_Message = ReplaceString(_Message, "%mbmsg%", _MBMessage)
	ProcedureReturn _Message
EndProcedure

Procedure _Log(MessageLevel.b, Message.s, OpenMB.b, MBTitle.s, MBMessage.s, MBFlags)
	If LoggerConfig\LogLevelDebug & MessageLevel
		Debug _FormatLogString(LoggerConfig\FormatDebug, Message, MBTitle, MBMessage)
	EndIf
	
	If LoggerConfig\LogLevelConsole & MessageLevel
		PrintN(_FormatLogString(LoggerConfig\FormatConsole, Message, MBTitle, MBMessage))
	EndIf
	
	;TODO: Write to file and return Message Requester if applicable.
EndProcedure

Procedure LogFatal(Message.s, ExitCode.i=-1, OpenMB.b=#False, MBTitle.s="Fatal Error", MBMessage.s="A fatal error has occured.", MBFlags=#PB_MessageRequester_Error)
	Protected a = _Log(#LoggingLevel_Fatal, Message, OpenMB, MBTitle, MBMessage, MBFlags)
	If ExitCode = -1
		ProcedureReturn a
	Else
		End ExitCode
	EndIf
EndProcedure

Procedure LogTrace(Message.s, OpenMB.b=#False, MBTitle.s="Debug...", MBMessage.s="Why is this even shown ?!?", MBFlags=#PB_MessageRequester_Info)
	ProcedureReturn _Log(#LoggingLevel_Trace, Message, OpenMB, MBTitle, MBMessage, MBFlags)
EndProcedure

Procedure LogDebug(Message.s, OpenMB.b=#False, MBTitle.s="Debug...", MBMessage.s="Why is this even shown ?!?", MBFlags=#PB_MessageRequester_Info)
	ProcedureReturn _Log(#LoggingLevel_Debug, Message, OpenMB, MBTitle, MBMessage, MBFlags)
EndProcedure

Procedure LogError(Message.s, OpenMB.b=#False, MBTitle.s="Error", MBMessage.s="An error has occured.", MBFlags=#PB_MessageRequester_Error)
	ProcedureReturn _Log(#LoggingLevel_Error, Message, OpenMB, MBTitle, MBMessage, MBFlags)
EndProcedure

Procedure LogWarn(Message.s, OpenMB.b=#False, MBTitle.s="Warning", MBMessage.s="A warning has been issued.", MBFlags=#PB_MessageRequester_Warning)
	ProcedureReturn _Log(#LoggingLevel_Warn, Message, OpenMB, MBTitle, MBMessage, MBFlags)
EndProcedure

Procedure LogInfo(Message.s, OpenMB.b=#False, MBTitle.s="Info", MBMessage.s="Do you really need to bother the user with basic info ?", MBFlags=#PB_MessageRequester_Info)
	ProcedureReturn _Log(#LoggingLevel_Info, Message, OpenMB, MBTitle, MBMessage, MBFlags)
EndProcedure
;}

;
;- Tests & Examples
;{

CompilerIf #PB_Compiler_IsMainFile
	; TODO: Add an example here
CompilerEndIf
;}
