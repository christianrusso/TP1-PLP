module TestsCatch where

import Router
import Test.HUnit
import SampleRoutes

-- evaluar t para correr todos los tests
--t = runTestTT allTestsCatch

allTestsCatch = test [
	"testCatch" ~: testCatch
	]

testCatch = test [
	-- Catedra
	["",":p0",":p0/:p1",":p0/:p1/:p2",":p0/:p1/:p2/:p3"] ~=? take 5 (paths (catch_all 42)),
	Just (42,[("p0","cualquier"),("p1","ruta")]) ~=? eval (catch_all 42) "cualquier/ruta",
	Just 0 ~=? exec (catch_all length) "",
	Just 3  ~=? exec (catch_all length) "foo/bar/baz",
 	-- eval con ruta no vacia
 	Just (15,[("p0","kal"),("p1","asdf"),("p2","sadf"),("p3","sd"),("p4","af"),("p5","asfd")]) ~=? eval (catch_all 15) "kal/asdf/sadf/sd/af/asfd",
 	-- exec con funcion
 	Just [("p1","def"),("p0","abc")] ~=? exec (catch_all reverse) "abc/def",
 	Just [("p0","abc"),("p1","def")] ~=? exec (catch_all id) "abc/def",
 	Just [] ~=? exec (catch_all reverse) ""
	]
