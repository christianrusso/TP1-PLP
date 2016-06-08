module TestsSplit where

import Router
import Test.HUnit
import SampleRoutes

-- evaluar t para correr todos los tests
--t = runTestTT allTestsSplit

allTestsSplit = test [
	"testSplit" ~: testSplit
	]

testSplit = test [
-- string vacío
 	split '/' "" ~=? [""],
-- sólo un delimitador
	split '/' "/" ~=? ["",""],
-- empieza con un delimitador
	split '/' "/foo" ~=? ["", "foo"],
-- consume el delimitador
	split '/' "alu/:lu/aprobadas" ~=? ["alu", ":lu", "aprobadas"],
-- empieza y termina con un delimitador
	split '|' "|hola|que|tal|" ~=? ["", "hola", "que", "tal", ""],
-- varios
	split '*' "hallo*wie*geht's**" ~=? ["hallo", "wie", "geht's", "", ""],
	split ' ' "alu/:lu/aprobadas" ~=? ["alu/:lu/aprobadas"],
	split ' ' "alu/ :lu/ aprobadas" ~=? ["alu/",":lu/","aprobadas"]
	]
