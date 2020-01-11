;{- Code Header
; ==- Basic Info -================================
;         Name: EndianSwapQ_SSE.pbi
;      Version: 1.0.0 (Experimental)
;       Author: Herwin Bozet
;  Create date: 11 January 2020, 08:33:48
; 
;  Description: An experimental version of "EndianSwapQ" from "Endianness.pbi" that
;                uses the SSE2 instruction set.
;               [speed and responsability to check support]
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.70 (x64) (Other versions untested)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;  License: WTFPL
; 
;}


;
;- Compiler Directives
;{

; The following line is only used to see if it works with it enabled, and for debugging.
;EnableExplicit

;}


;
;- Procedure
;{

;Procedure.q EndianSwapQSSE(Number.q)
; 	; Copy the input into XMM0
; 	MOVQ xmm0, Input
; 	
; 	; Clear the XMM1 register.
; 	PXOR xmm1, xmm1
; 	
; 	; Interleave XMM0 and XMM1.
; 	PUNPCKLBW xmm0, xmm1
; 	
; 	; BSWAP each dword
; 	! PSHUFHW xmm0, xmm0, 00011011b
; 	! PSHUFLW xmm0, xmm0, 00011011b
; 	
; 	; De-interleave XMM0
; 	PACKUSWB xmm0, xmm0
; 	
; 	; Swaps each dword.
; 	! PSHUFD xmm0, xmm0, 10110001b
; 	
; 	; Get the result
; 	MOVQ Output, xmm0
;	
;	ProcedureReturn Number
;EndProcedure

;}


;
;- Tests
;{

CompilerIf #PB_Compiler_IsMainFile
	
	
CompilerEndIf

;}

; IDE Options = PureBasic 5.70 LTS (Windows - x64)
; CursorPosition = 8
; Folding = -