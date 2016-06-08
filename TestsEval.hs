module TestsEval where

import Router
import Test.HUnit
import SampleRoutes

-- evaluar t para correr todos los tests
--t = runTestTT allTestsEval

allTestsEval = test [
	"testEval" ~: testEval
	]

testEval = test [
-- ruta vacía
  Just ("ver inicio", []) ~=? eval rutasFacultad "",
	Just ("aprueba alumno", [("nombre", "plp"), ("lu", "56-09")]) ~=? eval rutasFacultad "materia/plp/alu/56-09/aprobar",
	Just ("ver materias aprobadas por alumno", [("lu", "007-01")]) ~=? eval rutasFacultad "alu/007-01/aprobadas",
	Just ("aprueba alumno", [("nombre", "plp"), ("lu", "007-01") ]) ~=? eval rutasFacultad "materia/plp/alu/007-01/aprobar",
	Just ("inscribe alumno", [("nombre", "plp"), ("lu", "007-01") ]) ~=? eval rutasFacultad "materia/plp/alu/007-01/inscribir",
	Nothing ~=? eval rutasFacultad "materia/plp/inscribir",
	Nothing ~=? eval rutasFacultad "materia/plp/alu/007-01/ayuda",
	Nothing ~=? eval rutasFacultad "ver inicio",
	Nothing ~=? eval rutasFacultad "alu/007-01",
	Just ("0",[]) ~=? eval rutasSoloRoutes "cero",
	Nothing ~=? eval rutasSoloRoutes "cero/0",
	Just ("editar perfil",[("nombreUser","crusso")]) ~=? eval rutasFacebook "perfil/crusso/editar",
	Just ("aprueba alumno",[("nombre","plp"),("lu","679-10"),("nombre","plp2"),("lu","677-10"),("nombre","plp3"),("lu","679-11")]) ~=?	eval rutasComplicadas "materia/plp/alu/679-10/materia/plp2/alu/677-10/materia/plp3/alu/679-11/aprobar3",
	-- eval ruta vacia
 	Just (42,[]) ~=? eval (catch_all 42) ""
	]
