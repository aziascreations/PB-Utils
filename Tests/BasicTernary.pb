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
XIncludeFile "../Includes/UnitTest.pbi"
XIncludeFile "../Includes/BasicTernary.pbi"

;}


;- Tests
;{

;- > IfA()
Debug "-=# Testing 'IfA()' #=-"
AssertEqual(1, IfA(#True, 1, 2), "On #True")
AssertEqual(2, IfA(#False, 1, 2), "On #False")
Debug ""

;- > IfB()
Debug "-=# Testing 'IfB()' #=-"
AssertEqual(1, IfB(#True, 1, 2), "On #True")
AssertEqual(2, IfB(#False, 1, 2), "On #False")
Debug ""

;- > IfC()
Debug "-=# Testing 'IfC()' #=-"
AssertEqual('a', IfC(#True, 'a', 'b'), "On #True")
AssertEqual('b', IfC(#False, 'a', 'b'), "On #False")
Debug ""

;- > IfD()
Debug "-=# Testing 'IfD()' #=-"
AssertEqual(1.0, IfD(#True, 1.0, 2.0), "On #True")
AssertEqual(2.0, IfD(#False, 1.0, 2.0), "On #False")
Debug ""

;- > IfF()
Debug "-=# Testing 'IfF()' #=-"
AssertEqual(1.0, IfF(#True, 1.0, 2.0), "On #True")
AssertEqual(2.0, IfF(#False, 1.0, 2.0), "On #False")
Debug ""

;- > IfI()
Debug "-=# Testing 'IfI()' #=-"
AssertEqual(1, IfI(#True, 1, 2), "On #True")
AssertEqual(2, IfI(#False, 1, 2), "On #False")
Debug ""

;- > IfL()
Debug "-=# Testing 'IfL()' #=-"
AssertEqual(1, IfL(#True, 1, 2), "On #True")
AssertEqual(2, IfL(#False, 1, 2), "On #False")
Debug ""

;- > IfP()
Debug "-=# Testing 'IfP()' #=-"
Define A.i = 1, B.i = 2
Define *pA = @A, *pB = @B
AssertEqual(@A, IfP(#True, *pA, *pB), "On #True (Pointer address)")
AssertEqual(@B, IfP(#False, *pA, *pB), "On #False (Pointer address)")
AssertEqual(A, PeekI(IfP(#True, *pA, *pB)), "On #True (Pointed value)")
AssertEqual(B, PeekI(IfP(#False, *pA, *pB)), "On #False (Pointed value)")
Debug ""

;- > IfQ()
Debug "-=# Testing 'IfQ()' #=-"
AssertEqual(1, IfQ(#True, 1, 2), "On #True")
AssertEqual(2, IfQ(#False, 1, 2), "On #False")
Debug ""

;- > IfS()
Debug "-=# Testing 'IfS()' #=-"
AssertEqualStr("A", IfS(#True, "A", "B"), "On #True")
AssertEqualStr("B", IfS(#False, "A", "B"), "On #False")
Debug ""

;- > IfU()
Debug "-=# Testing 'IfU()' #=-"
AssertEqual('a', IfU(#True, 'a', 'b'), "On #True")
AssertEqual('b', IfU(#False, 'a', 'b'), "On #False")
Debug ""

;- > IfW()
Debug "-=# Testing 'IfW()' #=-"
AssertEqual(1, IfW(#True, 1, 2), "On #True")
AssertEqual(2, IfW(#False, 1, 2), "On #False")
Debug ""

;- > Results
Debug "-=# Results #=-"
Debug " * Passed: "+Str(PassedUnitTests)
Debug " * Failed: "+Str(FailedUnitTests)

;}
