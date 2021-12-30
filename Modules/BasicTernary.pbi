;{- Code Header
; ==- Basic Info -================================
;         Name: BasicTernary.pbi (Module)
;      Version: 3.0.0 - Common to all "PB-Utils" Includes
;       Author: Herwin Bozet
; 
;  Description: Gives a procedure that acts like the ternary operator in other languages.
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.70 (x86/x64) (Other versions untested)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;     Doc.: https://github.com/aziascreations/PB-Utils/Documentation/BasicTernary
;  License: Unlicensed
; 
;}


;- Module Declaration
;{

DeclareModule BasicTernary
	;-> Standard Constants
	#Version$ = "3.0.0"
	#Version_Major = 3
	#Version_Minor = 0
	#Version_Patch = 0
	
	;-> Procedures
	Declare.a IfA(Condition.b, TrueValue.a, FalseValue.a)
	Declare.b IfB(Condition.b, TrueValue.b, FalseValue.b)
	Declare.c IfC(Condition.b, TrueValue.c, FalseValue.c)
	Declare.d IfD(Condition.b, TrueValue.d, FalseValue.d)
	Declare.f IfF(Condition.b, TrueValue.f, FalseValue.f)
	Declare.i IfI(Condition.b, TrueValue.i, FalseValue.i)
	Declare.l IfL(Condition.b, TrueValue.l, FalseValue.l)
	Declare.i IfP(Condition.b, *TrueValue, *FalseValue)
	Declare.q IfQ(Condition.b, TrueValue.q, FalseValue.q)
	Declare.s IfS(Condition.b, TrueValue.s, FalseValue.s)
	Declare.u IfU(Condition.b, TrueValue.u, FalseValue.u)
	Declare.w IfW(Condition.b, TrueValue.w, FalseValue.w)
EndDeclareModule 

;}


;- Module Definition
;{

Module BasicTernary
	;-> Compiler Directives
	XIncludeFile "../Includes/BasicTernary.pbi"
EndModule

;}
