module TestsWrap where

import Router
import Test.HUnit
import SampleRoutes

-- evaluar t para correr todos los tests
--t = runTestTT allTestsWrap

allTestsWrap = test [
	"testWrap" ~: testWrap
	]

testWrap = test [
			-- de la catedra
 		    Just ("oicini rev", []) ~=? eval (wrap reverse rutasFacebook) "inicio",
 		    Just "foobar." ~=? exec (wrap(\f ctx -> f ctx ++ ".") rutasStringOps) "concat/foo/bar",
 		    -- obtiene los parametros y ejecuta la funcion
 		    Just ("lifrep ratide",[("nombreUser","crusso")]) ~=? eval (wrap reverse rutasFacebook) "perfil/crusso/editar",
 		    Just (13,[("nombreUser","crusso")]) ~=? eval (wrap length rutasFacebook) "perfil/crusso/editar",
 		    -- ejecuta una funcion mas dificil sobre una ruta mas compleja
 		    Just (["aprueba","alumno"],[("nombre","plp"),("lu","679-10"),("nombre","plp2"),("lu","677-10"),("nombre","plp3"),("lu","679-11")]) ~=? eval (wrap (split ' ') rutasComplicadas) "materia/plp/alu/679-10/materia/plp2/alu/677-10/materia/plp3/alu/679-11/aprobar3"
	]