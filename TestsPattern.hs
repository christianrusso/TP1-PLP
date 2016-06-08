module TestsPattern where

import Router
import Test.HUnit

-- evaluar t para correr todos los tests
--t = runTestTT allTestsPattern

allTestsPattern = test [
	"testPattern" ~: testPattern
	]

testPattern = test [
-- reconoce literales y capturas
 	pattern "/alu/:lu/aprobadas" ~=? [Literal "alu", Capture "lu", Literal "aprobadas"],
-- delimitadores consecutivos no afectan el resultado
	pattern "/alu/:lu//aprobadas" ~=? [Literal "alu", Capture "lu", Literal "aprobadas"],
-- string vacío
	pattern "" ~=? [],
-- un delimitador
	pattern "/" ~=? [],
-- sólo literales
	pattern "lit1/lit2/lit3/lit4" ~=? [Literal "lit1", Literal "lit2", Literal "lit3", Literal "lit4"],
-- sólo capturas
	pattern ":cap1/:cap2/:cap3/:cap4" ~=? [Capture "cap1", Capture "cap2", Capture "cap3", Capture "cap4"],
-- con muchos /, intercalados, al principio o al final
	pattern ":cap1//:cap2//:cap3//:cap4" ~=? [Capture "cap1", Capture "cap2", Capture "cap3", Capture "cap4"],
	pattern ":cap1///////" ~=? [Capture "cap1"],
	pattern "/////////:cap1///////" ~=? [Capture "cap1"],
	pattern "/////////:cap1" ~=? [Capture "cap1"],
	pattern "lit///////" ~=? [Literal "lit"],
	pattern "////////lit///////" ~=? [Literal "lit"],
	pattern "//////lit" ~=? [Literal "lit"],
-- varios	
	pattern "lit1/:cap1/:cap2/lit2/:cap3" ~=? [Literal "lit1", Capture "cap1", Capture "cap2", Literal "lit2", Capture "cap3"]
	]
