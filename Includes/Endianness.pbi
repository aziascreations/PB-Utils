;{- Code Header
; ==- Basic Info -================================
;         Name: Endianness.pbi
;      Version: 1.0.2
;      Authors: Herwin Bozet & djes
;  Create date: 9 June ‎2019, 21:04:51
; 
;  Description: A set of procedure that allow you to swap the endianness of a variable easily.
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.60-5.62 (x86 & x64) (Other versions untested)
;  Operating system: Windows 10 (Other platforms untested)
; 
; ==- Credits -===================================
;  djes: Original EndianSwapW(Number.l) procedure
;        https://www.purebasic.fr/english/viewtopic.php?f=19&t=17427
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;  License: Apache V2
; 
; ==- Documentation -=============================
;  See each procedures for a link to the relevant x86/x64 ASM instruction(s).
;
;}


; FIXME: IMPORTANT NOTICES !!!
; A second procedure was specially made for and .u (and .a) variables to avoid any potential problem that could happen
;  if you use "EndianSwapW" when declaring an implicitely typed variable.
; The compiler might think that you want to use a "Word" and not an "Unsigned Word, aka. Unicode", even if
;  the value returned be these procedure is exactly the same bit-wise.
; If your variable is explicitely typed, it shouldn't be a problem, but you should still use the correct one.
;
; Each of the procedures in this include uses the RAX register and its parts (EAX, AX, AL, AH).
; And in the case of "EndianSwapQ(...)" on x86, the EDX register is used.
; Keep this in mind if you call them while using ASM !


;
;- Compiler Options
;{

; The following line is only used to see if it works with it and for debugging.
;EnableExplicit

;}


;
;- Macros
;{

Macro EndianSwap(Number)
	CompilerSelect TypeOf(Number)
		CompilerCase #PB_Word
			EndianSwapW(Number)
		CompilerCase #PB_Unicode
			EndianSwapU(Number)
		CompilerCase #PB_Long
			EndianSwapL(Number)
		CompilerCase #PB_Integer
			EndianSwapI(Number)
		CompilerCase #PB_Quad
			EndianSwapQ(Number)
		CompilerDefault
			CompilerError "Unsupported value type given in '+EndianSwap(Number)' !"
	CompilerEndSelect
EndMacro

;}


;
;- Procedures
;{

;-> 1 Byte (B/A) (Nibble inverters)

; ROL r8/m8 -> Similar to a shift, but the bits loop
; https://www.aldeid.com/wiki/X86-assembly/Instructions/rol
Procedure.b NibbleSwapB(Number.b)
	EnableASM
		ROL Number, 4
	DisableASM
	
	ProcedureReturn Number
EndProcedure

Procedure.a NibbleSwapA(Number.a)
	EnableASM
		ROL Number, 4
	DisableASM
	
	ProcedureReturn Number
EndProcedure


;-> 2 Bytes (W/U)

; XCHG r8, r8 -> Where both r8 are parts of r16 -> (ax = al+ah)
; See: https://c9x.me/x86/html/file_module_x86_id_328.html
Procedure.w EndianSwapW(Number.w)
	EnableASM
		MOV ax,Number
		XCHG al,ah
		MOV Number,ax
	DisableASM
	
	ProcedureReturn Number
EndProcedure

Procedure.u EndianSwapU(Number.u)
	EnableASM
		MOV ax,Number
		XCHG al,ah
		MOV Number,ax
	DisableASM
	
	ProcedureReturn Number
EndProcedure


;-> 4 Bytes (L)

; Original code for "EndianSwapL(...)" by djes on the PureBasic forum.
; See: https://www.purebasic.fr/english/viewtopic.php?f=19&t=17427

; Improvement(s) made:
; * EAX Register returned directly -> MAY save a couple of cycles if the compiler doesn't optimize it already.
;                                     It does, it goes from ~687-690ms/1M calls to ~635ms/1M calls.

; BSWAP r32 -> Does the operation on the register itself.
; See: https://www.felixcloutier.com/x86/bswap
Procedure.l EndianSwapL(Number.l)
	EnableASM
		MOV eax,Number
		BSWAP eax
		ProcedureReturn
	DisableASM
EndProcedure


;-> 4-8 Bytes (I)

; EndianSwapI(Number.i)
; Had to be separated based on the CPU arch because its size varies based on it, and also because BSWAP uses
;  the register size to know what to do.
; And since x64 has 64bit registers while x86 doesn't, they have to be different.
CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
	
	; BSWAP r32 -> Does the operation on the register itself.
	; See: https://www.felixcloutier.com/x86/bswap
	Procedure.i EndianSwapI(Number.i)
		EnableASM
			MOV eax, Number
			BSWAP eax
			ProcedureReturn
		DisableASM
	EndProcedure
	
CompilerElseIf #PB_Compiler_Processor = #PB_Processor_x64
	
	; BSWAP r64 -> Does the operation on the register itself.
	; See: https://www.felixcloutier.com/x86/bswap
	Procedure.i EndianSwapI(Number.i)
		EnableASM
			MOV rax, Number
			BSWAP rax
			MOV Number, rax
		DisableASM
		
		ProcedureReturn Number
	EndProcedure
	
CompilerElse
	CompilerWarning "Unsupported CPU Architecture in Endianness.pbi for EndianSwapI(...) !"
CompilerEndIf


;-> 8 Bytes (Q)

; MOVBE could have been used, but the compiler kept giving a syntax error for some reason :/
; See: https://www.felixcloutier.com/x86/movbe
; Same thing with MOVSS and other SSE2 MOV ops with xmm regs.

; EndianSwapQ(Number.q)
; Had to be separated based on the CPU arch because x86 doesn't have an easy way of dealing with a 64bit variable
;  in its registers.
CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
	
	; Note: The xmm registers should be able to hold a quad on both x86 and x64, it might be a good idea to check it.
	
	; Note: The stack could have technically been used to leave EDX untouched, but when I used it,
	;        the "ProcedureReturn" kept throwing an "Invalid memory access" error.
	
	; BSWAP r32 -> Does the operation on the register itself.
	; See: https://www.felixcloutier.com/x86/bswap
	Procedure.q EndianSwapQ(Number.q)
		EnableASM
			MOV eax, dword [p.v_Number]
			MOV edx, dword [p.v_Number+4]
			
	 		BSWAP eax
	 		BSWAP edx
	 		
	 		MOV dword [p.v_Number+4], eax
	 		MOV dword [p.v_Number], edx
		DisableASM
		
		ProcedureReturn Number
	EndProcedure
	
CompilerElseIf #PB_Compiler_Processor = #PB_Processor_x64
	
	; BSWAP r64 -> Does the operation on the register itself.
	; See: https://www.felixcloutier.com/x86/bswap
	Procedure.q EndianSwapQ(Number.q)
		EnableASM
			MOV rdx, Number
			BSWAP rdx
			MOV Number, rdx
		DisableASM
		
		ProcedureReturn Number
	EndProcedure
	
CompilerElse
	CompilerWarning "Unsupported CPU Architecture in Endianness.pbi for EndianSwapQ(...) !"
CompilerEndIf

;}


;
;- Tests
;{

CompilerIf #PB_Compiler_IsMainFile
	Define VarB.b = $B5
	Debug "Byte:"
	Debug "0x"+RSet(Hex(VarB, #PB_Byte), 2, "0")+" -> 0x"+RSet(Hex(NibbleSwapB(VarB), #PB_Byte), 2, "0")
	Debug Str(VarB)+" -> "+Str(NibbleSwapB(VarB))
	Debug ""
	
	Define VarA.b = $B5
	Debug "Ascii:"
	Debug "0x"+RSet(Hex(VarA, #PB_Ascii), 2, "0")+" -> 0x"+RSet(Hex(NibbleSwapA(VarA), #PB_Ascii), 2, "0")
	Debug StrU(VarA, #PB_Ascii)+" -> "+StrU(NibbleSwapA(VarA), #PB_Ascii)
	Debug ""
	
	Define VarW.w = $B903
	Debug "Word:"
	Debug "0x"+RSet(Hex(VarW, #PB_Word), 4, "0")+" -> 0x"+RSet(Hex(EndianSwapW(VarW), #PB_Word), 4, "0")
	Debug Str(VarW)+" -> "+Str(EndianSwapW(VarW))
	Debug ""
	
	Define VarU.w = $B903
	Debug "Unicode:"
	Debug "0x"+RSet(Hex(VarU, #PB_Unicode), 4, "0")+" -> 0x"+RSet(Hex(EndianSwapU(VarU), #PB_Unicode), 4, "0")
	Debug StrU(VarU, #PB_Unicode)+" -> "+StrU(EndianSwapU(VarU), #PB_Unicode)
	Debug ""
	
	Define VarL.l = $E530A6F0
	Debug "Long:"
	Debug "0x"+RSet(Hex(VarL, #PB_Long), 8, "0")+" -> 0x"+RSet(Hex(EndianSwapL(VarL), #PB_Long), 8, "0")
	Debug Str(VarL)+" -> "+Str(EndianSwapL(VarL))
	Debug ""
	
	Debug "Integer:"
	CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
		Define VarI.i = $E530A6F0
		
		Debug "> 32 bits"
		Debug "0x"+RSet(Hex(VarI, #PB_Long), 8, "0")+" -> 0x"+RSet(Hex(EndianSwapL(VarI), #PB_Long), 8, "0")
		Debug Str(VarI)+" -> "+Str(EndianSwapL(VarI))
		Debug "> 64 bits"
		Debug "Use a 64 bits compiler or EndianSwapQ(...)"
		
	CompilerElseIf #PB_Compiler_Processor = #PB_Processor_x64
		Define VarI.i = $D34A096BD100F590
		
		Debug "> 32 bits"
		Debug "Use a 32 bits compiler or EndianSwapL(...)"
		Debug "> 64 bits"
		Debug "0x"+RSet(Hex(VarI, #PB_Quad), 16, "0")+" -> 0x"+RSet(Hex(EndianSwapI(VarI), #PB_Quad), 16, "0")
		Debug Str(VarI)+" -> "+Str(EndianSwapI(VarI))
		
	CompilerElse
		CompilerWarning "> Unsupported CPU Architecture for both x86 and x64."
	CompilerEndIf
	Debug ""
		
	Debug "Quad:"
	Define VarQ.q = $D34A096BD100F590
	CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
		
		Debug "> 32 bits method (x86 fallback)"
		Debug "0x"+RSet(Hex(VarQ, #PB_Quad), 16, "0")+" -> 0x"+RSet(Hex(EndianSwapQ(VarQ), #PB_Quad), 16, "0")
		Debug Str(VarQ)+" -> "+Str(EndianSwapQ(VarQ))
		Debug "> 64 bits method (???)"
		Debug "Use a 64 bits compiler"
		
	CompilerElseIf #PB_Compiler_Processor = #PB_Processor_x64
		
		Debug "> 32 bits method (x86 fallback)"
		Debug "Use a 32 bits compiler"
		Debug "> 64 bits method (???)"
		Debug "0x"+RSet(Hex(VarQ, #PB_Quad), 16, "0")+" -> 0x"+RSet(Hex(EndianSwapQ(VarQ), #PB_Quad), 16, "0")
		Debug Str(VarQ)+" -> "+Str(EndianSwapQ(VarQ))
		
	CompilerElse
		CompilerWarning "> Unsupported CPU Architecture for both x86 and x64."
	CompilerEndIf
CompilerEndIf

;}

; IDE Options = PureBasic 5.62 (Windows - x64)
; CursorPosition = 195
; FirstLine = 191
; Folding = ----
; EnableXP
; Compiler = PureBasic 5.62 (Windows - x86)