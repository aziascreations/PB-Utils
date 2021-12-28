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
Debug " * This test should be compiled for x86 and x64 to insure both of the compilers work properly !"
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


;- > EndianSwapI()
Define IntInput.i, IntOutput.i

Debug "-=# Testing 'EndianSwapI()' with sign bit #=-"
CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
	IntInput = $89ABCDEF
	IntOutput = $EFCDAB89
	AssertEqual($EFCDAB89, EndianSwapI($89ABCDEF), "Numeric equality on direct values")
	AssertBitwiseEqual($EFCDAB89, EndianSwapI($89ABCDEF), "Bitwise equality on direct values")
	AssertEqual(IntOutput, EndianSwapI(IntInput), "Numeric equality on typed variables")
	AssertBitwiseEqual(IntOutput, EndianSwapI(IntInput), "Bitwise equality on typed variables")
CompilerElseIf #PB_Compiler_Processor = #PB_Processor_x64
	IntInput = $D34A096BD100F590
	IntOutput = $90F500D16B094AD3
	AssertEqual($90F500D16B094AD3, EndianSwapI($D34A096BD100F590), "Numeric equality on direct values")
	AssertBitwiseEqual($90F500D16B094AD3, EndianSwapI($D34A096BD100F590), "Bitwise equality on direct values")
	AssertEqual(IntOutput, EndianSwapI(IntInput), "Numeric equality on typed variables")
	AssertBitwiseEqual(IntOutput, EndianSwapI(IntInput), "Bitwise equality on typed variables")
CompilerEndIf
Debug ""

Debug "-=# Testing 'EndianSwapI()' without sign bit #=-"
CompilerIf #PB_Compiler_Processor = #PB_Processor_x86
	IntInput = $1A2B3C4D
	LongOutput = $4D3C2B1A
	AssertEqual($4D3C2B1A, EndianSwapI($1A2B3C4D), "Numeric equality on direct values")
	AssertBitwiseEqual($4D3C2B1A, EndianSwapI($1A2B3C4D), "Bitwise equality on direct values")
	AssertEqual(LongOutput, EndianSwapI(IntInput), "Numeric equality on typed variables")
	AssertBitwiseEqual(LongOutput, EndianSwapI(IntInput), "Bitwise equality on typed variables")
CompilerElseIf #PB_Compiler_Processor = #PB_Processor_x64
	IntInput = $D34A096BD100F540
	IntOutput = $40F500D16B094AD3
	AssertEqual($40F500D16B094AD3, EndianSwapI($D34A096BD100F540), "Numeric equality on direct values")
	AssertBitwiseEqual($40F500D16B094AD3, EndianSwapI($D34A096BD100F540), "Bitwise equality on direct values")
	AssertEqual(IntOutput, EndianSwapI(IntInput), "Numeric equality on typed variables")
	AssertBitwiseEqual(IntOutput, EndianSwapI(IntInput), "Bitwise equality on typed variables")
CompilerEndIf
Debug ""


;- > EndianSwapQ()
Define QuadInput.q, QuadOutput.q

Debug "-=# Testing 'EndianSwapQ()' with sign bit #=-"
QuadInput = $D34A096BD100F590
QuadOutput = $90F500D16B094AD3
AssertEqual($90F500D16B094AD3, EndianSwapQ($D34A096BD100F590), "Numeric equality on direct values")
AssertBitwiseEqual($90F500D16B094AD3, EndianSwapQ($D34A096BD100F590), "Bitwise equality on direct values")
AssertEqual(QuadOutput, EndianSwapQ(QuadInput), "Numeric equality on typed variables")
AssertBitwiseEqual(QuadOutput, EndianSwapQ(QuadInput), "Bitwise equality on typed variables")
Debug ""

Debug "-=# Testing 'EndianSwapQ()' without sign bit #=-"
QuadInput = $D34A096BD100F540
QuadOutput = $40F500D16B094AD3
AssertEqual($40F500D16B094AD3, EndianSwapQ($D34A096BD100F540), "Numeric equality on direct values")
AssertBitwiseEqual($40F500D16B094AD3, EndianSwapQ($D34A096BD100F540), "Bitwise equality on direct values")
AssertEqual(QuadOutput, EndianSwapQ(QuadInput), "Numeric equality on typed variables")
AssertBitwiseEqual(QuadOutput, EndianSwapQ(QuadInput), "Bitwise equality on typed variables")
Debug ""


;- > Results
Debug "-=# Results #=-"
Debug " * Passed: "+Str(PassedUnitTests)
Debug " * Failed: "+Str(FailedUnitTests)

;}
