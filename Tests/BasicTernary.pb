;{- Code Header
; ==- Test Info -=================================
;  Tested file(s): Includes/BasicTernary.pbi
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
XIncludeFile "../Includes/UnitTest-Basic.pbi"
XIncludeFile "../Includes/BasicTernary.pbi"

;}


;- Tests
;{

;- > IfA()
Debug "-=# Testing 'IfA()' #=-"
AssertTrue(Bool(1 = IfA(#True, 1, 2)), "On #True")
AssertTrue(Bool(2 = IfA(#False, 1, 2)), "On #False")
Debug ""

;- > IfB()
Debug "-=# Testing 'IfB()' #=-"
AssertTrue(Bool(1 = IfB(#True, 1, 2)), "On #True")
AssertTrue(Bool(2 = IfB(#False, 1, 2)), "On #False")
Debug ""

;- > IfC()
Debug "-=# Testing 'IfC()' #=-"
AssertTrue(Bool('a' = IfC(#True, 'a', 'b')), "On #True")
AssertTrue(Bool('b' = IfC(#False, 'a', 'b')), "On #False")
Debug ""

;- > IfD()
Debug "-=# Testing 'IfD()' #=-"
AssertTrue(Bool(1.0 = IfD(#True, 1.0, 2.0)), "On #True")
AssertTrue(Bool(2.0 = IfD(#False, 1.0, 2.0)), "On #False")
Debug ""

;- > IfF()
Debug "-=# Testing 'IfF()' #=-"
AssertTrue(Bool(1.0 = IfF(#True, 1.0, 2.0)), "On #True")
AssertTrue(Bool(2.0 = IfF(#False, 1.0, 2.0)), "On #False")
Debug ""

;- > IfI()
Debug "-=# Testing 'IfI()' #=-"
AssertTrue(Bool(1 = IfI(#True, 1, 2)), "On #True")
AssertTrue(Bool(2 = IfI(#False, 1, 2)), "On #False")
Debug ""

;- > IfL()
Debug "-=# Testing 'IfL()' #=-"
AssertTrue(Bool(1 = IfL(#True, 1, 2)), "On #True")
AssertTrue(Bool(2 = IfL(#False, 1, 2)), "On #False")
Debug ""

;- > IfP()
Debug "-=# Testing 'IfP()' #=-"
Define A.i = 1, B.i = 2
Define *pA = @A, *pB = @B
AssertTrue(Bool(@A = IfP(#True, *pA, *pB)), "On #True (Pointer address)")
AssertTrue(Bool(@B = IfP(#False, *pA, *pB)), "On #False (Pointer address)")
AssertTrue(Bool(A = PeekI(IfP(#True, *pA, *pB))), "On #True (Pointed value)")
AssertTrue(Bool(B = PeekI(IfP(#False, *pA, *pB))), "On #False (Pointed value)")
Debug ""

;- > IfQ()
Debug "-=# Testing 'IfQ()' #=-"
AssertTrue(Bool(1 = IfQ(#True, 1, 2)), "On #True")
AssertTrue(Bool(2 = IfQ(#False, 1, 2)), "On #False")
Debug ""

;- > IfS()
Debug "-=# Testing 'IfS()' #=-"
AssertTrue(Bool("A" = IfS(#True, "A", "B")), "On #True")
AssertTrue(Bool("B" = IfS(#False, "A", "B")), "On #False")
Debug ""

;- > IfU()
Debug "-=# Testing 'IfU()' #=-"
AssertTrue(Bool('a' = IfU(#True, 'a', 'b')), "On #True")
AssertTrue(Bool('b' = IfU(#False, 'a', 'b')), "On #False")
Debug ""

;- > IfW()
Debug "-=# Testing 'IfW()' #=-"
AssertTrue(Bool(1 = IfW(#True, 1, 2)), "On #True")
AssertTrue(Bool(2 = IfW(#False, 1, 2)), "On #False")
Debug ""

;- > Results
Debug "-=# Results #=-"
Debug " * Passed: "+Str(PassedUnitTests)
Debug " * Failed: "+Str(FailedUnitTests)

;}
