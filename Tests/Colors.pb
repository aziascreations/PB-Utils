;{- Code Header
; ==- Test Info -=================================
;  Tested file(s): Includes/Colors.pbi
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
XIncludeFile "../Includes/Colors.pbi"

;}


;- Tests
;{

;- > RGBHex()
Debug "-=# Testing '+RGBHex()' #=-"
AssertTrue(Bool($AB1278 = RGBHex($7812AB)), "$AB1278 to $7812AB")
Debug ""

;- > RGBAHex()
Debug "-=# Testing '+RGBAHex()' #=-"
AssertTrue(Bool($AB1278FE = RGBAHex($FE7812AB)), "$AB1278FE to $FE7812AB")
Debug ""

;- > Results
Debug "-=# Results #=-"
Debug " * Passed: "+Str(PassedUnitTests)
Debug " * Failed: "+Str(FailedUnitTests)

;}
