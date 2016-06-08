module TestsPaths where

import Router
import Test.HUnit
import SampleRoutes

-- evaluar t para correr todos los tests
--t = runTestTT allTestsPaths

allTestsPaths = test [
	"testPaths" ~: testPaths
	]

testPaths = test [
-- Routes con Route, Scope y Many
	paths rutasFacultad ~=? ["", "ayuda", "materia/:nombre/alu/:lu/inscribir",
								"materia/:nombre/alu/:lu/aprobar", "alu/:lu/aprobadas"],
-- Route
	paths rutasAuto ~=? ["patente/:pat"],
	paths rutasSoloRoutes ~=? ["cero","uno","dos","tres","cuatro","cinco","seis"],
-- Many [Route]
	paths rutaSimple ~=? ["inicio"],
-- Many[]
	paths rutaVacia ~=? [],
-- Scope pp (Route)
	paths rutasSeguro ~=? ["patente/:pat/seguro/:seg"],
-- Many adentro de scope | Route, Scope pp (Many [Route]), Route
	paths rutasFacebook ~=? ["inicio", "amigos", "perfil/:nombreUser/editar", "alu/:lu/aprobadas"],
	paths rutasMuchosScopes ~=? ["materia/:nombre/alu/:lu/inscribir1","materia/:nombre/alu/:lu/aprobar1","materia/:nombre/alu/:lu/inscribir2","materia/:nombre/alu/:lu/aprobar2","materia/:nombre/alu/:lu/inscribir3","materia/:nombre/alu/:lu/aprobar3","alu/:lu/aprobadas"],
-- Tres scopes y many anidados | Many [Scope pp (Many [Scope pp (Many[Route])])]
	paths rutasComplicadas ~=? ["","ayuda","materia/:nombre/alu/:lu/inscribir","materia/:nombre/alu/:lu/materia/:nombre/alu/:lu/aprobar2","materia/:nombre/alu/:lu/materia/:nombre/alu/:lu/materia/:nombre/alu/:lu/inscribir3","materia/:nombre/alu/:lu/materia/:nombre/alu/:lu/materia/:nombre/alu/:lu/aprobar3","materia/:nombre/alu/:lu/aprobar","alu/:lu/aprobadas"],
-- varios
	paths rutasModeloYAnio ~=? ["patente/:pat/modelo", "patente/:pat/anio"]
	]
