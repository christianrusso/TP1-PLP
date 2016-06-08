module TestsMatches where

import Router
import Test.HUnit

-- evaluar t para correr todos los tests
--t = runTestTT allTestsMatches

allTestsMatches = test [
	"testMatches" ~: testMatches
	]

testMatches = test [
-- devuelve las capturas correctas y la ruta sobrante
-- cuando sobra ruta
  	matches ["materia", "plp", "alu", "007-1"] [Literal "materia", Capture "nombre"] ~=? Just (["alu", "007-1"], [("nombre", "plp")]),
-- cuando no sobra ruta
  	matches ["materia", "plp", "alu", "007-1"] [Capture "materia", Capture "nombre", Capture "alumno", Capture "lu"] ~=? Just ([],[("materia","materia"),("nombre","plp"),("alumno","alu"),("lu","007-1")]),
  	matches ["materia"] [Capture "mat"] ~=? Just ([],[("mat","materia")]),
-- devuelve Nothing cuando la ruta no matchea con [PathPattern] 
-- por diferencia de literales
   	matches ["materia", "plp", "alu", "007-1"] [Literal "materia", Literal "nombre", Literal "nombre2", Literal "nombre3"] ~=? Nothing,
  	matches ["materia", "plp", "alu", "007-1"] [Literal "materia", Literal "nombre"] ~=? Nothing,
  	matches ["materia"] [Literal "algo"] ~=? Nothing,
  	matches ["materia", "plp", "alu", "007-1"] [Literal "materia", Literal "nombre", Literal "nombre", Literal "nombre", Literal "nombre"] ~=? Nothing,
-- porque la [PathPattern] tiene más elementos
  	matches ["otra", "ruta"] [Literal "otra", Literal "ruta", Capture "aa"] ~=? Nothing,
-- ruta vacía
  	matches [] [Capture "ayuda"] ~=? Nothing,
  	matches [] [Literal "algo"] ~=? Nothing
	]
