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
Define AsciiInput.a = $AB, AsciiOutput.a = $BA
AssertEqual($BA, NibbleSwapA($AB), "Equality on direct values")
AssertEqual(AsciiOutput, NibbleSwapA(AsciiInput), "Equality on typed variables")
Debug ""


;- > NibbleSwapB()
Define ByteInput.b, ByteOutput.b

Debug "-=# Testing 'NibbleSwapB()' with sign bit #=-"
ByteInput = $AB
ByteOutput = $BA
AssertEqual($BA, NibbleSwapB($AB), "Numeric equality on direct values")
AssertBitwiseEqual($BA, NibbleSwapB($AB), "Bitwise equality on direct values")
AssertEqual(ByteOutput, NibbleSwapB(ByteInput), "Numeric equality on typed variables")
AssertBitwiseEqual(ByteOutput, NibbleSwapB(ByteInput), "Bitwise equality on typed variables")
Debug ""

Debug "-=# Testing 'NibbleSwapB()' without sign bit #=-"
ByteInput = $12
ByteOutput = $21
AssertEqual($21, NibbleSwapB($12), "Numeric equality on direct values")
AssertBitwiseEqual($21, NibbleSwapB($12), "Bitwise equality on direct values")
AssertEqual(ByteOutput, NibbleSwapB(ByteInput), "Numeric equality on typed variables")
AssertBitwiseEqual(ByteOutput, NibbleSwapB(ByteInput), "Bitwise equality on typed variables")
Debug ""


;- > EndianSwapU()
Debug "-=# Testing 'EndianSwapU()' #=-"
Define UnicodeInput.u = $ABCD, UnicodeOutput.u = $CDAB
AssertTrue(Bool($CDAB = EndianSwapU($ABCD)), "Numeric equality on direct values")
AssertBitwiseEqual($CDAB, EndianSwapU($ABCD), "Bitwise equality on direct values")
AssertEqual(UnicodeOutput, EndianSwapU(UnicodeInput), "Numeric equality on typed variables")
AssertBitwiseEqual(UnicodeOutput, EndianSwapU(UnicodeInput), "Bitwise equality on typed variables")
Debug ""


;- > EndianSwapW()
Define WordInput.w, WordOutput.w

Debug "-=# Testing 'EndianSwapW()' with sign bit #=-"
WordInput = $ABCD
WordOutput = $CDAB
AssertEqual($CDAB, EndianSwapW($ABCD), "Numeric equality on direct values")
AssertBitwiseEqual($CDAB, EndianSwapW($ABCD), "Bitwise equality on direct values")
AssertEqual(WordOutput, EndianSwapW(WordInput), "Numeric equality on typed variables")
AssertBitwiseEqual(WordOutput, EndianSwapW(WordInput), "Bitwise equality on typed variables")
Debug ""

Debug "-=# Testing 'EndianSwapW()' without sign bit #=-"
WordInput = $1234
WordOutput = $3412
AssertEqual($3412, EndianSwapW($1234), "Numeric equality on direct values")
AssertBitwiseEqual($3412, EndianSwapW($1234), "Bitwise equality on direct values")
AssertEqual(WordOutput, EndianSwapW(WordInput), "Numeric equality on typed variables")
AssertBitwiseEqual(WordOutput, EndianSwapW(WordInput), "Bitwise equality on typed variables")
Debug ""


;- > EndianSwapL()
Define LongInput.l, LongOutput.l

Debug "-=# Testing 'EndianSwapL()' with sign bit #=-"
LongInput = $89ABCDEF
LongOutput = $EFCDAB89
AssertEqual($EFCDAB89, EndianSwapL($89ABCDEF), "Numeric equality on direct values")
AssertBitwiseEqual($EFCDAB89, EndianSwapL($89ABCDEF), "Bitwise equality on direct values")
; The 2 next tests appears to fail with the x64 compiler when comparing them, however, the hex value seems to be equal...
; This may be due to an undocummented typecasting from long to int by PureBasic itself.
AssertEqual(LongOutput, EndianSwapL(LongInput), "Numeric equality on typed variables")
AssertBitwiseEqual(LongOutput, EndianSwapL(LongInput), "Bitwise equality on typed variables")
AssertEqual(LongOutput & $FFFFFFFF, EndianSwapL(LongInput) & $FFFFFFFF, "Numeric equality on typed variables with 'AND' bitwise operation")
AssertBitwiseEqual(LongOutput & $FFFFFFFF, EndianSwapL(LongInput) & $FFFFFFFF, "Bitwise equality on typed variables with 'AND' bitwise operation")
Debug ""

Debug "-=# Testing 'EndianSwapL()' without sign bit #=-"
LongInput = $1A2B3C4D
LongOutput = $4D3C2B1A
AssertEqual($4D3C2B1A, EndianSwapL($1A2B3C4D), "Numeric equality on direct values")
AssertBitwiseEqual($4D3C2B1A, EndianSwapL($1A2B3C4D), "Bitwise equality on direct values")
AssertEqual(LongOutput, EndianSwapL(LongInput), "Numeric equality on typed variables")
AssertBitwiseEqual(LongOutput, EndianSwapL(LongInput), "Bitwise equality on typed variables")
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
