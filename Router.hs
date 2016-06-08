module Router where

import Data.List
import Data.Maybe


data PathPattern = Literal String | Capture String deriving (Eq, Show)

data Routes f = Route [PathPattern] f | Scope [PathPattern] (Routes f) | Many [Routes f] deriving Show

type PathContext = [(String, String)]

-- Ejercicio 1: Dado un elemento separador y una lista, se deber a partir la lista en sublistas de acuerdo a la aparicíon del separador (sin incluirlo).
split :: Eq a => a -> [a] -> [[a]]
split delimiter = foldr (\c r -> 	
							if c == delimiter
							then [] : r
							else (c : head r) : tail r) 
						[[]]

-- Ejercicio 2: A partir de una cadena que denota un patrón de URL se deberá construir la secuencia de literales y capturas correspondiente.
pattern :: String -> [PathPattern]
pattern s = map (\str -> 	
					if head str == ':'
					then Capture (tail str) 
					else Literal str)
				(filter (not . null) (split '/' s))

-- Ejercicio 3: Obtiene el valor registrado en una captura determinada. Se puede suponer que la captura está definida en el contexto.
get :: String -> PathContext -> String
get cap pc = snd (case find (\x -> fst(x) == cap) pc of Just c -> c)

-- Ejercicio 4: Dadas una ruta particionada y un patrón de URL, trata de aplicar el patrón a la ruta y devuelve, en caso de que
--              la ruta sea un prefijo válido para el patrón, el resto de la ruta que no se haya llegado a consumir y el contexto capturado hasta el punto alcanzado.
matches ::[String] -> [PathPattern] -> Maybe ([String], PathContext)
matches ss ps = if valid ss ps 
				then Just (reminder ss ps, context ss ps)
				else Nothing

valid :: [String] -> [PathPattern] -> Bool
valid ss ps | length ss < length ps = False
            | otherwise = foldr (&&) True (zipWith (\s p -> case p of
																	Capture c -> True
																	Literal l -> s == l) ss ps)

reminder :: [String] -> [PathPattern] -> [String]
reminder ss ps = drop (length ps) ss

context :: [String] -> [PathPattern] -> PathContext
context ss ps = map (\(x, Capture c) -> (c, x))
                    (filter (\(x, y) -> case y of 
											Capture c -> True
											otherwise -> False) 
                    (zip ss ps))

-- DSL para rutas
route :: String -> a -> Routes a
route s f = Route (pattern s) f

scope :: String -> Routes a -> Routes a
scope s r = Scope (pattern s) r

many :: [Routes a] -> Routes a
many l = Many l

-- Ejercicio 5: Definir el fold para el tipo Routes f y su tipo. Se puede usar recursión explícita.
foldRoutes :: ([PathPattern] -> f -> b) -> ([PathPattern] -> b -> b) -> ([b] -> b) -> (Routes f) -> b
foldRoutes fRoute fScope fMany x = case x of
										Route ps h -> fRoute ps h
										Scope ps y -> fScope ps (rec y)
										Many xs-> fMany (map rec xs)
									where
										rec = foldRoutes fRoute fScope fMany

-- Auxiliar para mostrar patrones. Es la inversa de pattern.
patternShow :: [PathPattern] -> String
patternShow ps = concat $ intersperse "/" ((map (\p -> case p of
  Literal s -> s
  Capture s -> (':':s)
  )) ps)

-- Ejercicio 6: Genera todos los posibles paths para una ruta definida.
paths :: Routes a -> [String]
paths = foldRoutes 	(\ps h -> [patternShow ps]) 
					(\ps r -> map (\p -> (patternShow ps) ++ (if (not . null) p then "/" ++ p else "")) r)
					(\rs -> concat rs)

-- Ejercicio 7: Evalúa un path con una definición de ruta y, en caso de haber coincidencia, obtiene el handler correspondiente 
--              y el contexto de capturas obtenido.
eval :: Routes a -> String -> Maybe (a, PathContext)
eval rts url = eval' rts (filter (not . null) (split '/' url))

eval' :: Routes a -> [String] -> Maybe (a, PathContext)
eval' = foldRoutes 	(\ps h -> \ss -> (\(reminder, pc) -> 	if null reminder
															then Just (h, pc) 
															else Nothing) =<< (matches ss ps))
					-- fRoute = Si la URL matchea y consumimos toda la URL, es una coincidencia y devolvemos el handler y contexto.
					-- 			Si no, devolvemos Nothing.

					(\ps r -> \ss -> (\(reminder, pc) -> maybeAppend (r reminder) pc) =<< (matches ss ps))
					-- fScope = Si la URL matchea con el patron actual y lo que resta matchea recursivamente, devolvemos el (algun) handler y contexto
					-- 			con el que matchea recursivamente.
					--			Si no, devolvemos Nothing.

					(\rs -> \ss -> (\r -> r ss) =<< (find (\r -> case r ss of 
													Just x -> True
													Nothing -> False) rs))
					-- fMany = Devolvemos el resultado del primer match, o Nothing si no matchea con ninguno.


maybeAppend :: Maybe (a, PathContext) -> PathContext -> Maybe (a, PathContext)
maybeAppend Nothing pc = Nothing
maybeAppend (Just x) pc = Just (fst x, pc ++ (snd x))

-- Ejercicio 8: Similar a eval, pero aquí se espera que el handler sea una función que recibe como entrada el contexto 
--              con las capturas, por lo que se devolverá el resultado de su aplicación, en caso de haber coincidencia.
exec :: Routes (PathContext -> a) -> String -> Maybe a
exec routes path = (\(f, pc) -> Just (f pc)) =<< (eval routes path)

-- Ejercicio 9: Permite aplicar una funci ́on sobre el handler de una ruta. Esto, por ejemplo, podría permitir la ejecución 
--              concatenada de dos o más handlers.
wrap :: (a -> b) -> Routes a -> Routes b
wrap f = foldRoutes	(\pp h ->	Route pp (f h)) (\ps r -> Scope ps r) (\rs -> Many rs)

-- Ejercicio 10: Genera un Routes que captura todas las rutas, de cualquier longitud. A todos los patrones devuelven el mismo valor. 
--               Las capturas usadas en los patrones se deberán llamar p0, p1, etc. 
catch_all :: a -> Routes a
catch_all h = Many [Route (pattern (concat ["/:p" ++ (show i) | i <- [0..j - 1]])) h | j <- [0..]]
