;{- Code Header
; ==- Test Info -=================================
;  Tested file(s): Includes/Endianness.pbi
; 
; ==- Compatibility -=============================
;  Compiler version: PureBasic 5.62-5.70 (x86/x64)
;  Operating system: Windows (Other platforms untested)
; 
; ==- Links & License -===========================
;   Github: https://github.com/aziascreations/PB-Utils
;  License: WTFPL
; 
;}


;- Test Setup
;{

EnableExplicit
XIncludeFile "../Includes/UnitTest.pbi"
XIncludeFile "../Includes/Endianness.pbi"

;}


;- Tests
;{

;- > Remarks()
Debug "-=# Remarks #=-"
Debug " * Implicit types will only be tested when signed types are used !"
Debug ""

;- > NibbleSwapA()
Debug "-=# Testing 'NibbleSwapA()' #=-"
AssertTrue(Bool($BA = NibbleSwapA($AB)), "$AB to $BA")
Debug ""

;- > NibbleSwapB()
Debug "-=# Testing 'NibbleSwapB()' #=-"
Define ByteInput.b, ByteOutput.b

ByteInput = $AB
ByteOutput = $BA
AssertTrue(Bool($BA <> NibbleSwapB($AB)), "$AB to $BA - Different due to implicit types and sign bit")
AssertTrue(Bool(ByteOutput = NibbleSwapB(ByteInput)), "$AB to $BA - Equal with explicit types")

ByteInput = $12
ByteOutput = $21
AssertTrue(Bool($21 = NibbleSwapB($12)), "$12 to $21 - Equal with implicit types (Due to sign bit staying at '0')")
AssertTrue(Bool(ByteOutput = NibbleSwapB(ByteInput)), "$12 to $21 - Equal with explicit types")
Debug ""

;- > EndianSwapU()
Debug "-=# Testing 'EndianSwapU()' #=-"
AssertTrue(Bool($CDAB = EndianSwapU($ABCD)), "$ABCD to $CDAB")
Debug ""

;- > EndianSwapW()
Debug "-=# Testing 'EndianSwapW()' #=-"
Define WordInput.w, WordOutput.w

WordInput = $ABCD
WordOutput = $CDAB
AssertTrue(Bool($CDAB <> EndianSwapW($ABCD)), "$ABCD to $CDAB - Different due to implicit types and sign bit")
AssertTrue(Bool(WordOutput = EndianSwapW(WordInput)), "$ABCD to $CDAB - Equal with explicit types")

WordInput = $1234
WordOutput = $3412
AssertTrue(Bool($3412 = EndianSwapW($1234)), "$1234 to $3412 - Equal with implicit types (Due to sign bit staying at '0')")
AssertTrue(Bool(WordOutput = EndianSwapW(WordInput)), "$1234 to $3412 - Equal with explicit types")
Debug ""



;- > EndianSwapL()
Debug "-=# Testing 'EndianSwapL()' #=-"
Define LongInput.l, LongOutput.l, LongBuffer.l

LongInput = $89ABCDEF
LongOutput = $EFCDAB89
AssertTrue(Bool($EFCDAB89 <> EndianSwapL($89ABCDEF)), "$89ABCDEF to $EFCDAB89 - Different (Direct values)")
AssertTrue(Bool(LongOutput = EndianSwapL(LongInput)), "$89ABCDEF to $EFCDAB89 - Equal (Typed variables)")

LongBuffer = EndianSwapL(LongInput)
AssertTrue(Bool(LongOutput = EndianSwapL(LongInput)), "$89ABCDEF to $EFCDAB89 - Equal (Typed variables & Buffer output variable)")

; These appears to fail with the x64 compiler when comparing them, however, the hex value seems to be equal...

;Debug Hex($89ABCDEF) + " -> " + Str($89ABCDEF)
;Debug Hex($EFCDAB89) + " -> " + Str($EFCDAB89)
;Debug Hex(LongInput) + " -> " + Str(LongInput)
;Debug Hex(LongOutput) + " -> " + Str(LongOutput)
;Debug Hex(LongBuffer) + " -> " + Str(LongBuffer)
;Debug Hex(EndianSwapL(LongInput)) + " -> " + Str(EndianSwapL(LongInput))

LongInput = $1A2B3C4D
LongOutput = $4D3C2B1A
AssertTrue(Bool($4D3C2B1A = EndianSwapL($1A2B3C4D)), "$1A2B3C4D to $4D3C2B1A - Equal with implicit types (Due to sign bit staying at '0')")
AssertTrue(Bool(LongOutput = EndianSwapL(LongInput)), "$1A2B3C4D to $4D3C2B1A - Equal with explicit types")
Debug ""

; 	Debug "Integer:"
; 	CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
; 		Define VarI.i = $E530A6F0
; 		
; 		Debug "> 32 bits"
; 		Debug "0x"+RSet(Hex(VarI, #PB_Long), 8, "0")+" -> 0x"+RSet(Hex(EndianSwapL(VarI), #PB_Long), 8, "0")
; 		Debug Str(VarI)+" -> "+Str(EndianSwapL(VarI))
; 		Debug "> 64 bits"
; 		Debug "Use a 64 bits compiler or EndianSwapQ(...)"
; 		
; 	CompilerElseIf #PB_Compiler_Processor = #PB_Processor_x64
; 		Define VarI.i = $D34A096BD100F590
; 		
; 		Debug "> 32 bits"
; 		Debug "Use a 32 bits compiler or EndianSwapL(...)"
; 		Debug "> 64 bits"
; 		Debug "0x"+RSet(Hex(VarI, #PB_Quad), 16, "0")+" -> 0x"+RSet(Hex(EndianSwapI(VarI), #PB_Quad), 16, "0")
; 		Debug Str(VarI)+" -> "+Str(EndianSwapI(VarI))
; 		
; 	CompilerElse
; 		CompilerWarning "> Unsupported CPU Architecture for both x86 and x64."
; 	CompilerEndIf
; 	Debug ""
; 		
; 	Debug "Quad:"
; 	Define VarQ.q = $D34A096BD100F590
; 	CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
; 		
; 		Debug "> 32 bits method (x86 fallback)"
; 		Debug "0x"+RSet(Hex(VarQ, #PB_Quad), 16, "0")+" -> 0x"+RSet(Hex(EndianSwapQ(VarQ), #PB_Quad), 16, "0")
; 		Debug Str(VarQ)+" -> "+Str(EndianSwapQ(VarQ))
; 		Debug "> 64 bits method (???)"
; 		Debug "Use a 64 bits compiler"
; 		
; 	CompilerElseIf #PB_Compiler_Processor = #PB_Processor_x64
; 		
; 		Debug "> 32 bits method (x86 fallback)"
; 		Debug "Use a 32 bits compiler"
; 		Debug "> 64 bits method (???)"
; 		Debug "0x"+RSet(Hex(VarQ, #PB_Quad), 16, "0")+" -> 0x"+RSet(Hex(EndianSwapQ(VarQ), #PB_Quad), 16, "0")
; 		Debug Str(VarQ)+" -> "+Str(EndianSwapQ(VarQ))
; 		
; 	CompilerElse
; 		CompilerWarning "> Unsupported CPU Architecture for both x86 and x64."
; 	CompilerEndIf
; CompilerEndIf

;- > Results
Debug "-=# Results #=-"
Debug " * Passed: "+Str(PassedUnitTests)
Debug " * Failed: "+Str(FailedUnitTests)

;}
