module TestsExec where

import Router
import Test.HUnit
import SampleRoutes

-- evaluar t para correr todos los tests
--t = runTestTT allTestsExec

allTestsExec = test [
	"testExec" ~: testExec
	]

testExec = test [
 		     --Just 2 ~=? exec rutasFacultadLength "materia/plp/alu/56-09/aprobar"
 		     Just "foobaraaabbb" ~=? exec rutasContat "megaConcat/foo/bar/aaa/bbb",
 		     Just "foobar" ~=? exec rutasContat "concat/foo/bar",
 		     Just 1 ~=? exec rutaslength "length/a",
 		     Just 5 ~=? exec rutaslength "length/abcde",
 		     Just "a" ~=? exec rutasTake "take1/abcdefghijklmnopqrs",
 		     Just "abcdefghi" ~=? exec rutasTake "take9/abcdefghijklmnopqrs"
	]