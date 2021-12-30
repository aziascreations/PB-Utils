;{- Code Header
; ==- Basic Info -================================
;         Name: Endianness.pbi (Module)
;      Version: 3.0.0 - Common to all "PB-Utils" Includes
;       Author: Herwin Bozet
; 
;  Description: A set of procedure that allow you to swap the endianness of a variable easily.
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.70 (x86/x64) (Other versions untested)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Credits -===================================
;  djes: Original EndianSwapL(Number.l) procedure.
;        https://www.purebasic.fr/english/viewtopic.php?f=19&t=17427
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;     Doc.: https://github.com/aziascreations/PB-Utils/Documentation/Endianness
;  License: Unlicensed
; 
; ==- Documentation Remarks -=====================
;  See each procedures for a link to the relevant x86/x64 ASM instruction(s).
;  + desc, and link back to the readme in the repo.
;
;}


;- Module Declaration
;{

DeclareModule Endianness
	;-> Standard Constants
	#Version$ = "3.0.0"
	#Version_Major = 3
	#Version_Minor = 0
	#Version_Patch = 0
	
	;-> Procedures
	Declare.a NibbleSwapA(Number.a)
	Declare.b NibbleSwapB(Number.b)
	Declare.w EndianSwapW(Number.w)
	Declare.u EndianSwapU(Number.u)
	Declare.l EndianSwapL(Number.l)
	Declare.i EndianSwapI(Number.i)
	Declare.q EndianSwapQ(Number.q)
EndDeclareModule 

;}


;- Module Definition
;{

Module Endianness
	;-> Compiler Directives
	XIncludeFile "../Includes/Endianness.pbi"
EndModule

;}
