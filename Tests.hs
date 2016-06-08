import TestsCatch 
import TestsEval
import TestsExec
import TestsGet
import TestsMatches
import TestsPaths
import TestsPattern
import TestsSplit
import TestsWrap

import Test.HUnit

-- evaluar t para correr todos los tests
t = runTestTT allTests

allTests = test [
	"allTestsCatch" ~: allTestsCatch,
	"allTestsEval" ~: allTestsEval,
	"allTestsExec" ~: allTestsExec,
	"allTestsGet" ~: allTestsGet,
	"allTestsMatches" ~: allTestsMatches,
	"allTestsPaths" ~: allTestsPaths,
	"allTestsPattern" ~: allTestsPattern,
	"allTestsSplit" ~: allTestsSplit,
	"allTestsWrap" ~: allTestsWrap
	]