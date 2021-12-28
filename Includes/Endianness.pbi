;{- Code Header
; ==- Basic Info -================================
;         Name: Endianness.pbi
;      Version: 1.1.0
;       Author: Herwin Bozet
;  Create date: 9 June 2019, 21:04:51
; 
;  Description: A set of procedure that allow you to swap the endianness of a variable easily.
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.62-5.70 (x86/x64)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Credits -===================================
;  djes: Original EndianSwapL(Number.l) procedure.
;        https://www.purebasic.fr/english/viewtopic.php?f=19&t=17427
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;     Doc.: https://github.com/aziascreations/PB-Utils/Documentation/Endianness
;  License: WTFPL
; 
; ==- Documentation -=============================
;  See each procedures for a link to the relevant x86/x64 ASM instruction(s).
;  + desc, and link back to the readme in the repo.
;
;}


;- Notes
;{

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

; ROL r8/m8 -> Similar to a shift, but the bits loop
; https://www.aldeid.com/wiki/X86-assembly/Instructions/rol

; XCHG r8, r8 -> Where both r8 are parts of r16 -> (ax = al+ah)
; See: https://c9x.me/x86/html/file_module_x86_id_328.html

; BSWAP r32/r64 -> Does the operation on the register itself.
; See: https://www.felixcloutier.com/x86/bswap

;}


;- Compiler Directives
;{

CompilerIf #PB_Compiler_Processor <> #PB_Processor_x86 And #PB_Compiler_Processor <> #PB_Processor_x64
	CompilerError "The 'Endianness.pbi' includes can only be compiled for x86 or x64 CPU architectures !"
CompilerEndIf

;}


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


;- Procedures
;{

;-> 1 Byte (B/A) (Nibble inverters)

Procedure.b NibbleSwapB(Number.b)
	EnableASM
		ROL Number, 4
	DisableASM
	
	ProcedureReturn Number & $FF
EndProcedure

Procedure.a NibbleSwapA(Number.a)
	EnableASM
		ROL Number, 4
	DisableASM
	
	ProcedureReturn Number
EndProcedure


;-> 2 Bytes (W/U)

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
	
	Procedure.i EndianSwapI(Number.i)
		EnableASM
			MOV eax, Number
			BSWAP eax
			ProcedureReturn
		DisableASM
	EndProcedure
	
CompilerElseIf #PB_Compiler_Processor = #PB_Processor_x64
	
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
; TODO: Check again since using "!" can fix this issue.
; Same thing with MOVSS and other SSE2 MOV ops with xmm regs.

; EndianSwapQ(Number.q)
; Had to be separated based on the CPU arch because x86 doesn't have an easy way of dealing with a 64bit variable
;  in its registers.
CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
	
	; Note: A version of this procedure that uses xmm registers and SSE2 instructions can be made to suit both
	;        x86 and x64, but the performances would likely take a hit. (~8 instructions with XMM regs.)
	
	; Note: The stack could have technically been used to leave EDX untouched, but when I used it,
	;        the "ProcedureReturn" kept throwing an "Invalid memory access" error.
	
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
