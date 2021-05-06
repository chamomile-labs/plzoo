--   ____        __
--  / __ \      /_ |
-- | |  | |      | |
-- | |  | |      | |
-- | |__| |  _   | |
--  \___\_\ (_)  |_|
--
-- USES: if/then/else, pattern matching

listAfterKey :: [Int] -> Int -> [Int]
listAfterKey [] x = []
listAfterKey (x:xs) y =
	if x == y then xs
	else listAfterKey xs y

--   ____        ___
--  / __ \      |__ \
-- | |  | |        ) |
-- | |  | |       / /
-- | |__| |  _   / /_
--  \___\_\ (_) |____|
--
-- USES: if/then/else, pattern matching

startStrings :: [String] -> Char -> [String]
startStrings [] c = []
startStrings (x:xs) c =
	if head x == c then x:(startStrings xs c)
	else startStrings xs c

--   ____        ____
--  / __ \      |___ \
-- | |  | |       __) |
-- | |  | |      |__ <
-- | |__| |  _   ___) |
--  \___\_\ (_) |____/
--
-- USES: pattern matching

merge :: [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) = x:y:(merge xs ys)

--   ____        _  _
--  / __ \      | || |
-- | |  | |     | || |_
-- | |  | |     |__   _|
-- | |__| |  _     | |
--  \___\_\ (_)    |_|
--
-- USES: pattern matching, guards

mylength :: [a] -> Int
mylength [] = 0
mylength (x:xs) = 1 + mylength xs

pad :: [a] -> Int -> a -> [a]
pad xs len e
	| (len < mylength xs) = xs
	| (mylength xs /= len) = pad (xs ++ [e]) len e
	| otherwise = xs

mergepad :: [a] -> [a] -> [a]
mergepad [] ys = []
mergepad xs ys
	| lenxs > lenys = merge xs (pad ys lenxs (head xs))
	| lenys > lenxs = merge (pad xs lenys (head xs)) ys
	| otherwise     = merge xs ys
	where lenxs = mylength xs
	      lenys = mylength ys

--   ____        _____
--  / __ \      | ____|
-- | |  | |     | |__
-- | |  | |     |___ \
-- | |__| |  _   ___) |
--  \___\_\ (_) |____/
--
-- USES: list comprehension, pattern matching
--
-- After discovering that one can do [(x,y) | x <- [1..n], y <- [1..n]] to 'zip'
--   two lists I instantly had a feeling that this would come in handy for this
--   problem. Upon trying it, I saw that some of the points it generated were
--   outside of the distance threshold from the origin, so I simply added the
--   condition that each point should be strictly within distance d.

-- Also noteworthy is that I generated points containing values up d-1 rather
--   than d, because the distance from the origin to a point (x, d) or (d, y)
--   will always be greater than d given that x or y are at least 1 (which the
--   constraints for this problem guarantee). E.g. sqrt(1^2 + 4^2) > 4.
--   I could have let the filter condition filter these extra points out but
--   it seems like a waste of CPU cycles.

pointsInCircle :: Int -> [(Int, Int)]
pointsInCircle d = [(x,y) | x <- [1..(d-1)], y <- [1..(d-1)], (x^2 + y^2) < d^2]

--   ____    ___        __
--  / __ \  |__ \      /_ |
-- | |  | |    ) |      | |
-- | |  | |   / /       | |
-- | |__| |  / /_   _   | |
--  \___\_\ |____| (_)  |_|

cyclicn :: (Int -> Int) -> Int -> Int -> Bool
cyclicn f start n = cyclicnHelper f start n start

cyclicnHelper :: (Int -> Int) -> Int -> Int -> Int -> Bool
cyclicnHelper f arg n start
	| n > 0 =
		if (f arg) == start then True
		else cyclicnHelper (f) (f arg) (n-1) start
	| n == 0 = False

--   ____    ___        ___
--  / __ \  |__ \      |__ \
-- | |  | |    ) |        ) |
-- | |  | |   / /        / /
-- | |__| |  / /_   _   / /_
--  \___\_\ |____| (_) |____|

evenSquares :: [Int] -> [Int]
evenSquares [] = []
evenSquares xs = map (\n -> n * n) (filter (\n -> mod n 2 == 0) xs)

--   ____    ___        ____
--  / __ \  |__ \      |___ \
-- | |  | |    ) |       __) |
-- | |  | |   / /       |__ <
-- | |__| |  / /_   _   ___) |
--  \___\_\ |____| (_) |____/

startStringsHOF :: [String] -> Char -> [String]
startStringsHOF [] c = []
startStringsHOF xs c = filter (\s -> head s == c) xs

--   ____    ___        _  _
--  / __ \  |__ \      | || |
-- | |  | |    ) |     | || |_
-- | |  | |   / /      |__   _|
-- | |__| |  / /_   _     | |
--  \___\_\ |____| (_)    |_|

strictlyIncreasing :: [Int] -> Bool
strictlyIncreasing [] = False
strictlyIncreasing [x] = True
strictlyIncreasing [x,y] = y > x
strictlyIncreasing [x,y,z] = z > y && y > x
strictlyIncreasing (x:y:ys) = y > x && strictlyIncreasing (y:ys)

subseq :: [a] -> [[a]]
subseq [] = [[]]
subseq (x:xs) = (subseq xs) ++ (map (x:) (subseq xs))

incsubseq :: [Int] -> [[Int]]
incsubseq [] = []
incsubseq xs = filter (strictlyIncreasing) (subseq xs)

--   ____    ___        _____
--  / __ \  |__ \      | ____|
-- | |  | |    ) |     | |__
-- | |  | |   / /      |___ \
-- | |__| |  / /_   _   ___) |
--  \___\_\ |____| (_) |____/

freq :: String -> Char -> Int
freq str c = mylength (filter (\letter -> letter == c) str)
