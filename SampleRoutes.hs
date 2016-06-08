module SampleRoutes where
	
import Router

rutaVacia = many [
  ]


rutaSimple = many [
  route "inicio"       "ver inicio"  
  ]

rutasFacebook = many [
  route "inicio"       "ver inicio",
  route "amigos"        "buscar amigos",
  scope "perfil/:nombreUser" $ many [
    route "editar"   "editar perfil"
  ],
  route "alu/:lu/aprobadas"  "ver materias aprobadas por alumno"
  ]

rutasComplicadas = many [
  route ""             "ver inicio",
  route "ayuda"        "ver ayuda",
  scope "materia/:nombre/alu/:lu" $ many [
    route "inscribir"   "inscribe alumno",
    scope "materia/:nombre/alu/:lu" $ many [
    route "aprobar2"     "aprueba alumno",
    scope "materia/:nombre/alu/:lu" $ many [
    route "inscribir3"   "inscribe alumno",
    route "aprobar3"     "aprueba alumno"
  ]
  ],
    route "aprobar"     "aprueba alumno"
  ],
  route "alu/:lu/aprobadas"  "ver materias aprobadas por alumno"
  ]

rutasSoloRoutes = many [
  route "cero"		"0",
  route "uno"		"1",
  route "dos"       "2",
  route "tres"      "3",
  route "cuatro"    "4",
  route "cinco"     "5",
  route "seis"      "6"
  ]

rutasFacultad = many [
  route ""             "ver inicio",
  route "ayuda"        "ver ayuda",
  scope "materia/:nombre/alu/:lu" $ many [
    route "inscribir"   "inscribe alumno",
    route "aprobar"     "aprueba alumno"
  ],
  route "alu/:lu/aprobadas"  "ver materias aprobadas por alumno"
  ]


rutasMuchosScopes = many [
  scope "materia/:nombre/alu/:lu" $ many [
    route "inscribir1"   "inscribe alumno 1",
    route "aprobar1"     "aprueba alumno 1"
  ],
  scope "materia/:nombre/alu/:lu" $ many [
    route "inscribir2"   "inscribe alumno 2",
    route "aprobar2"     "aprueba alumno 2"
  ],
  scope "materia/:nombre/alu/:lu" $ many [
    route "inscribir3"   "inscribe alumno 3",
    route "aprobar3"     "aprueba alumno 3"
  ],
  route "alu/:lu/aprobadas"  "ver materias aprobadas por alumno"
  ]

--rutasFacultadLength = many [
--  route ""             length,
--  route "ayuda"        length,
--  scope "materia/:nombre/alu/:lu" $ many [
--    route "inscribir"   length,
--    route "aprobar"     length
--  ],
--  route "alu/:lu/aprobadas"  length
--  ]

auto = "patente/:pat"
rutasAuto = route auto "ver auto"
rutasSeguro = scope auto (route "seguro/:seg" "ver seguro")
rutasModeloYAnio = scope auto (many [route "modelo" "ver modelo", route "anio" "ver anio de fabricacion"])

rutasStringOps = route "concat/:a/:b" (\ctx -> (get "a" ctx) ++ (get "b" ctx))

rutasContat = many [
	route "concat/:a/:b" (\ctx -> (get "a" ctx) ++ (get "b" ctx)),
	route "megaConcat/:a/:b/:c/:d" (\ctx -> (get "a" ctx) ++ (get "b" ctx) ++ (get "c" ctx) ++ (get "d" ctx))
	]

rutaslength = route "length/:a" (\ctx -> length (get "a" ctx))

rutasTake = many [
	route "take1/:a" (\ctx -> take 1 (get "a" ctx)),
	route "take2/:a" (\ctx -> take 2 (get "a" ctx)),
	route "take3/:a" (\ctx -> take 3 (get "a" ctx)),
	route "take4/:a" (\ctx -> take 4 (get "a" ctx)),
	route "take5/:a" (\ctx -> take 5 (get "a" ctx)),
	route "take6/:a" (\ctx -> take 6 (get "a" ctx)),
	route "take7/:a" (\ctx -> take 7 (get "a" ctx)),
	route "take8/:a" (\ctx -> take 8 (get "a" ctx)),
	route "take9/:a" (\ctx -> take 9 (get "a" ctx))
	]



