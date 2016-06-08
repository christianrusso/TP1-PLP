module TestsGet where

import Router
import Test.HUnit

-- evaluar t para correr todos los tests
--t = runTestTT allTestsGet

allTestsGet = test [
	"testGet" ~: testGet
	]

testGet = test [
-- obtiene el valor correcto
  	get "nombre" [("nombre", "plp"), ("lu", "007-1")] ~=? "plp",
-- funciona con el string vacío como clave
  	get "" [("", "plp"), ("lu", "007-1")] ~=? "plp",
-- si una clave está definida más de una vez devuelve la primera
  	get "nombre1" [("nombre1", "n"), ("nombre1", "o"), ("lu", "007-1")] ~=? "n",
-- devolviendo cadenas vacias?
  	get "nombre" [("nombre", " "), ("lu", "007-1")] ~=? " ",
  	get "nombre" [("nombre", ""), ("lu", "007-1")] ~=? ""
	]
