-- A recursive descent parser for simple assignment statements

-- The BNF grammar is:
--   <asst>   --> id := <expr>
--   <expr>   --> <term> | <term> + <expr> | <term> - <expr>
--   <term>   --> <factor> | <factor> * <term>
--   <factor> --> id | int_constant | (<expr>)

data CST
  = Asst DCST String ACST
  | BadCST String

data ACST
  = Expr BCST
  | BadACST String

data BCST
  = Term CCST String BCST
  | Term2 CCST
  | BadBCST String

data CCST
  = Factor DCST String CCST
  | Factor2 DCST
  | BadCCST String

data DCST
  = Id String
  | Int_constant String
  | Expr2 String ACST String
  | Expr3 String ACST String String BCST
  | Expr4 String ACST String BCST
  | BadDCST String

--                       _
--                      (_)
--  _ __   __ _ _ __ ___ _ _ __   __ _
-- | '_ \ / _` | '__/ __| | '_ \ / _` |
-- | |_) | (_| | |  \__ \ | | | | (_| |
-- | .__/ \__,_|_|  |___/_|_| |_|\__, |
-- | |                            __/ |
-- |_|                           |___/

parse :: [String] -> CST
parse [] = (BadCST "emptiness fills my soul (errno 0xDEADBEEF)")
parse [x] = (BadCST ("unexpected lexeme '" ++ x ++ "'"))
parse (id:":=":lexemes) =
  if (na == (length lexemes)) then
    (Asst dcst ":=" acst)
  else
    (BadCST "found unexpected lexemes")
  where
    (acst, na) = parseA lexemes
    (dcst, nd) = parseD [id]
parse lexemes = (BadCST ("Expected assignment statement, received "
  ++ (concat (map (++ " ") lexemes))))

parseA :: [[Char]] -> (ACST, Int)
parseA [] = ((BadACST "expected lexeme, received none"), 0)
parseA lexemes =
  ((Expr bcst), nb)
  where
    (bcst, nb) = parseB lexemes

parseB :: [[Char]] -> (BCST, Int)
parseB [] = ((BadBCST "expected lexeme, received none"), 0)
parseB (term:"+":lexemes) =
  ((Term ccst "+" bcst), na+2)
  where
    (bcst, na) = parseB lexemes
    (ccst, nc) = parseC [term]
parseB (term:"-":lexemes) =
  ((Term ccst "-" bcst), na+2)
  where
    (bcst, na) = parseB lexemes
    (ccst, nc) = parseC [term]
parseB (lexemes) =
  ((Term2 ccst), nc)
  where
    (ccst, nc) = parseC lexemes

parseC :: [[Char]] -> (CCST, Int)
parseC [] = ((BadCCST "expected lexeme, received none"), 0)
parseC (factor:"*":lexemes) =
  ((Factor dcst "*" ccst), nc+2)
  where
    (ccst, nc) = parseC lexemes
    (dcst, nd) = parseD [factor]
parseC lexemes =
  ((Factor2 dcst), nd)
  where
    (dcst, nd) = parseD lexemes

parseD :: [[Char]] -> (DCST, Int)
parseD [] = ((BadDCST "expected lexeme, received none"), 0)
parseD (token:[]) =
  if nump token then ((Int_constant token), 1)
  else
    if (validID token) then ((Id token), 1)
    else ((BadDCST ("'" ++ token ++ "'" ++ " is not a valid Id")), 1)
parseD ("(":lexemes) -- hairy
  | (outer == []) || (outer == [")"]) = ((Expr2 "(" acst ")"), na+2)
  | (head (tail outer)) == ")" =
    ((Expr4 "(" acst ")" bcst), na+nb+2)
  | (head (tail outer)) == "+"
    || (head (tail outer)) == "-"
    || (head (tail outer)) == "*"
     = ((Expr3 "(" acst ")" (head (tail outer)) bcst ), na+nb+3)
  | otherwise = ((BadDCST ("expected an operator after ')', received '"
    ++ (head (tail outer)) ++ "'")), 1 + length lexemes)
  where (inner, outer) = splitAtClosingParen lexemes
        (acst, na) = parseA inner
        (bcst, nb) = parseB (tail (tail outer))
parseD lexemes = ((BadDCST (concat lexemes)), 0)

--  _____ _____  _____ _____  _           __     __
-- |  __ \_   _|/ ____|  __ \| |        /\\ \   / /
-- | |  | || | | (___ | |__) | |       /  \\ \_/ /
-- | |  | || |  \___ \|  ___/| |      / /\ \\   /
-- | |__| || |_ ____) | |    | |____ / ____ \| |
-- |_____/_____|_____/|_|    |______/_/    \_\_|

instance Show (CST) where
  show cst = displayCST cst 0

displayCST :: CST -> Int -> String
displayCST (Asst dcst walrus acst) i =
  "asst\n" ++ (displayDCST dcst (i+1))
   ++ (tab (i+1)) ++ walrus ++ "\n" ++ (displayACST acst (i+1))
displayCST (BadCST err) i =
  "(General Error) malformed input: " ++ err

displayACST :: ACST -> Int -> String
displayACST (Expr bcst) i =
  (tab i) ++ "expr\n" ++ (displayBCST bcst (i+1))
displayACST (BadACST err) i =
  "(Asst Error) malformed input: " ++ err

displayBCST :: BCST -> Int -> String
displayBCST (Term ccst op bcst) i =
  (tab i) ++ "term\n" ++ (displayCCST ccst (i+1))
  ++ (tab i) ++ op ++ "\n" ++ (displayBCST bcst (i))
displayBCST (Term2 ccst) i =
  (tab i) ++ "term\n" ++ (displayCCST ccst (i+1))
displayBCST (BadBCST err) i =
  "(Expr Error) malformed input: " ++ err

displayCCST :: CCST -> Int -> String
displayCCST (Factor dcst op ccst) i =
  (tab i) ++ "factor\n" ++ (displayDCST dcst (i+1))
  ++ (tab i) ++ op ++ "\n" ++ (displayCCST ccst i)
displayCCST (Factor2 dcst) i =
  (tab i) ++ "factor\n" ++ (displayDCST dcst (i+1))
displayCCST (BadCCST err) i =
  "(Term Error) malformed input: " ++ err

displayDCST :: DCST -> Int -> String
displayDCST (Id token) i =
  (tab i) ++ "Id " ++ token ++ "\n"
displayDCST (Int_constant token) i =
  (tab i) ++ "const " ++ token ++ "\n"
displayDCST (Expr3 paren1 acst paren2 operator bcst) i =
  (tab i) ++ "(\n" ++ (displayACST acst (i+1)) ++ (tab i) ++ ")\n" ++
  (tab i) ++ operator ++ "\n" ++ (displayBCST bcst (i+1))
displayDCST (Expr4 paren1 acst paren2 bcst) i =
  (tab i) ++ "(\n" ++ (displayACST acst (i+1)) ++ (tab i) ++ ")\n" ++
  (displayBCST bcst (i+1))

displayDCST (Expr2 paren1 acst paren2) i =
  (tab i) ++ "(\n" ++ (displayACST acst (i+1)) ++
  (tab i) ++ ")\n"
displayDCST (BadDCST err) i =
  "(Factor Error) malformed input: " ++ err

--  _    _ _______ _____ _       _____
-- | |  | |__   __|_   _| |     / ____|
-- | |  | |  | |    | | | |    | (___
-- | |  | |  | |    | | | |     \___ \
-- | |__| |  | |   _| |_| |____ ____) |
--  \____/   |_|  |_____|______|_____/

nump :: String -> Bool
nump "" = False
nump xs = numpHelper xs

numpHelper :: String -> Bool
numpHelper "" = True
numpHelper (x:xs) =
  if (x == '0' || x == '1' || x == '2' || x == '3' || x == '4' ||
      x == '5' || x == '6' || x == '7' || x == '8' || x == '9')
    then numpHelper xs
  else False

tab :: Int -> String
--tab n = take n (cycle "\t")
tab n = concat (replicate n "  ")

validID :: String -> Bool
validID token
  | token == "+" = False
  | token == "-" = False
  | token == "*" = False
  | token == " " = False
  | token == "(" = False
  | token == ")" = False
  | otherwise = True

splitAtClosingParen :: [String] -> ([String],[String])
splitAtClosingParen [] = ([],[])
splitAtClosingParen [x] = if x == ")" then ([],[x]) else ([x],[])
splitAtClosingParen xs = splitAtClosingParenHelper xs [] 0

splitAtClosingParenHelper :: [String] -> [String] -> Int -> ([String],[String])
splitAtClosingParenHelper [] inner n = (inner, [])
splitAtClosingParenHelper [x] inner n =
  if x == ")" then (inner, [x]) else ((inner ++ [x]), [])
splitAtClosingParenHelper (x:xs) inner n
  | x == ")" =
    if n /= 0 then splitAtClosingParenHelper xs (inner ++ [")"]) (n-1)
    else (inner, (")":xs))
  | x == "(" = splitAtClosingParenHelper xs (inner ++ ["("]) (n+1)
  | otherwise = splitAtClosingParenHelper xs (inner ++ [x]) n

--  _   _  ____  _____  ______    _____ ____  _    _ _   _ _______
-- | \ | |/ __ \|  __ \|  ____|  / ____/ __ \| |  | | \ | |__   __|
-- |  \| | |  | | |  | | |__    | |   | |  | | |  | |  \| |  | |
-- | . ` | |  | | |  | |  __|   | |   | |  | | |  | | . ` |  | |
-- | |\  | |__| | |__| | |____  | |___| |__| | |__| | |\  |  | |
-- |_| \_|\____/|_____/|______|  \_____\____/ \____/|_| \_|  |_|

leafnodes :: CST -> Int
leafnodes (Asst factor walrus expr) =
  1 + (leafnodesD factor) + (leafnodesA expr)
leafnodes (BadCST err) = 0

leafnodesA :: ACST -> Int
leafnodesA (Expr expr) = leafnodesB expr
leafnodesA (BadACST err) = 0

leafnodesB :: BCST -> Int
leafnodesB (Term ccst operator bcst) =
  1 + (leafnodesC ccst) + (leafnodesB bcst)
leafnodesB (Term2 ccst) = leafnodesC ccst
leafnodesB (BadBCST err) = 0

leafnodesC :: CCST -> Int
leafnodesC (Factor dcst operator ccst) =
  1 + (leafnodesD dcst) + (leafnodesC ccst)
leafnodesC (Factor2 dcst) = leafnodesD dcst
leafnodesC (BadCCST err) = 0

leafnodesD :: DCST -> Int
leafnodesD (Id id) = 1
leafnodesD (Int_constant const) = 1
leafnodesD (Expr2 paren1 acst paren2) =
  2 + (leafnodesA acst)
leafnodesD (Expr3 paren1 acst paren2 op bcst) =
  3 + (leafnodesA acst) + (leafnodesB bcst)
leafnodesD (Expr4 paren1 acst paren2 bcst) =
  2 + (leafnodesA acst) + (leafnodesB bcst)
leafnodesD (BadDCST err) = 0

internalnodes :: CST -> Int
internalnodes (Asst factor walrus expr) =
  1 + (internalnodesD factor) + (internalnodesA expr)
internalnodes (BadCST err) = 0

internalnodesA:: ACST -> Int
internalnodesA (Expr expr) = 1 + (internalnodesB expr)
internalnodesA (BadACST err) = 0

internalnodesB:: BCST -> Int
internalnodesB (Term ccst operator bcst) =
  1 + (internalnodesC ccst) + (internalnodesB bcst)
internalnodesB (Term2 ccst) = 1 + (internalnodesC ccst)
internalnodesB (BadBCST err) = 0

internalnodesC :: CCST -> Int
internalnodesC (Factor dcst operator ccst) =
  1 + (internalnodesD dcst) + (internalnodesC ccst)
internalnodesC (Factor2 dcst) = 1 + (internalnodesD dcst)
internalnodesC (BadCCST err) = 0

internalnodesD :: DCST -> Int
internalnodesD (Id id) = 0
internalnodesD (Int_constant const) = 0
internalnodesD (Expr2 paren1 acst paren2) =
  (internalnodesA acst)
internalnodesD (Expr3 paren1 acst paren2 op bcst) =
  1 + (internalnodesA acst) + (internalnodesB bcst)
internalnodesD (Expr4 paren1 acst paren2 bcst) =
  1 + (internalnodesA acst) + (internalnodesB bcst)
internalnodesD (BadDCST err) = 0

--  _______ ______  _____ _______ _____
-- |__   __|  ____|/ ____|__   __/ ____|
--    | |  | |__  | (___    | | | (___
--    | |  |  __|  \___ \   | |  \___ \
--    | |  | |____ ____) |  | |  ____) |
--    |_|  |______|_____/   |_| |_____/

test :: [String] -> IO()
test lexemes = putStr (
  "Lexemes: " ++ (show lexemes) ++ "\n\n" ++ (show cst)
  ++ "\nLeaf nodes: " ++ (show (leafnodes cst))
  ++ "\nInternal nodes: " ++ (show (internalnodes cst)))
  where cst = parse lexemes

testerr :: [String] -> IO()
testerr lexemes = putStr (
  "Lexemes: " ++ (show lexemes) ++ "\n\n" ++ (show cst))
  where cst = parse lexemes

test1 = test ["xyz",":=","x","+","(","2","*","y",")"]
test2 = test ["x",":=","5"]
test3 = test ["test3",":=","5","+","2"]
test4 = test ["test4",":=","5","-","foo"]
test5 = test ["test5",":=","bar","*","5"]
test6 = test ["test6",":=","1","+","2","*","3"]
test7 = test ["test7",":=","(","1","+","2",")","*","3"]
test8 = test ["test8",":=","(","5",")"]
test9 = test ["test9",":=","(","(","5",")",")"]
test10 = test ["test10",":=","x","+","(","y","-","z",")"]
test11 = test ["test11",":=","x","+","(","y","-","z",")","+","w"]
test12 = test ["test12",":=","x","*","(","y","-","z",")","+","w"]
test13 = test ["test13",":=","x","*","(","y","-","(","z","+","5",")",")"]
test14 = test ["test14",":=","x","*","(","y","-","(","z","+","5",")","+","w",")"]
test15 = test ["test15",":=","x","*","(","y","-","(","z","+","5",")","+","w",")","+","7"]
test16 = test ["test16",":=","1","+","(","2","*","x",")","-","3","*","(","4","+","(","5",")",")"]
test17 = test ["matryoshka",":=","(","(","(","(","(","(","(","(","(","(","10",")",")",")",")",")",")",")",")",")",")"]

test18 = putStrLn "The following tests will demonstrate how the parser reacts to malformed input.\nNB: the parse preceding an errant string is still printed."
test19 = testerr []
test20 = testerr ["x"]
test21 = testerr ["x",":="]
test22 = testerr ["+",":=","5"]
test23 = testerr ["x",":=","5","+",")"]
test24 = testerr ["x",":=","(","5","+"]
test25 = testerr ["x",":=","5","(","10",")"]
test26 = testerr ["x",":=","5","*","("]
test27 = testerr ["x",":=","5","*","(","1","+",")"]
