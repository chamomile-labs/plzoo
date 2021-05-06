--   ____        __
--  / __ \      /_ |
-- | |  | |      | |
-- | |  | |      | |
-- | |__| |  _   | |
--  \___\_\ (_)  |_|

--- BEGIN BST code from class ---

data BST a = EmptyTree | BSTNode a (BST a) (BST a)

initTree :: a -> (BST a)
initTree n = (BSTNode n EmptyTree EmptyTree)

bstinsert :: Ord a => a -> (BST a) -> (BST a)
bstinsert elem EmptyTree = initTree elem
bstinsert elem (BSTNode root left right) =
	if (elem < root) then (BSTNode root (bstinsert elem left) right)
	else (BSTNode root left (bstinsert elem right))

findTree :: Ord a => a -> (BST a) -> Bool
findTree elem EmptyTree = False
findTree elem (BSTNode root left right) =
	if (elem == root) then True
	else if (elem < root) then findTree elem left
	else findTree elem right

treeToList :: Ord a => (BST a) -> [a]
treeToList EmptyTree = []
treeToList (BSTNode root left right) =
	(treeToList left) ++ [root] ++ (treeToList right)

--- END BST code from class ---

data CellT = Cell Int String deriving (Eq, Ord, Show)
-- CELL COMPARISON: Int (the id)

data CellT2 = Cell2 Int String deriving (Eq, Show)

instance Ord CellT2 where
	(Cell2 id1 s1) < (Cell2 id2 s2) =
		if (s1 == s2) then (id1 < id2)
		else (s1 < s2)

-- treeToList (insert (Cell2 (-1) "abraham") (insert (Cell2 99 "abraham") (insert (Cell2 2 "barb") (initTree (Cell2 5 "al")))))

--   ____        ___
--  / __ \      |__ \
-- | |  | |        ) |
-- | |  | |       / /
-- | |__| |  _   / /_
--  \___\_\ (_) |____|

hunter :: Int -> Int
hunter 0 = 1
hunter 1 = 2
hunter 2 = 3
hunter n = hunterHelper n 3 [1,2,3]

hunterHelper :: Int -> Int -> [Int] -> Int
hunterHelper n i memo =
	if (length memo == n+1) then atIndex n memo
	else hunterHelper n (i+1) (memo ++ [value])
		where value = (2 * (atIndex (i-3) memo)) - (atIndex (i-1) memo)

atIndex :: Int -> [a] ->  a
atIndex n xs = atIndexHelper n 0 xs

atIndexHelper :: Int -> Int -> [a] -> a
atIndexHelper n i (x:xs) =
	if i == n then x
	else atIndexHelper n (i+1) xs

--   ____        ____
--  / __ \      |___ \
-- | |  | |       __) |
-- | |  | |      |__ <
-- | |__| |  _   ___) |
--  \___\_\ (_) |____/

{-
Digraph Interface:
	insert a [a] Digraph -> Digraph
	deadend Digraph -> [Node a]
	disconnected Digraph -> [Node a]
	showNodes Digraph -> [Node a]
	showEdges Digraph -> [Edge a]
	show Digraph -> String

Note: nodes must be a member of the Show and Eq typeclasses

The insert function presents an adjacency-list esque interface.

Usage and Examples:

insert 'A' ['B'] EmptyDigraph
	==>  'A' -> 'B'
showNodes (insert 'A' ['B'] EmptyDigraph)
	==>  ['A','B']
deadend (insert 'A' ['B'] EmptyDigraph)
	==>  ['B']

insert 'B' ['C'] (insert 'A' ['B'] EmptyDigraph)
	==>  'A' -> 'B', 'B' -> 'C'
showNodes (insert 'B' ['C'] (insert 'A' ['B'] EmptyDigraph))
	==> ['A','B','C']
deadend (insert 'B' ['C'] (insert 'A' ['B'] EmptyDigraph))
	==> ['C']

insert 1 [2,3,4,5] EmptyDigraph
	==> 1 -> 2, 1 -> 3, 1 -> 4, 1 -> 5
deadend (insert 1 [2,3,4,5] EmptyDigraph)
	==> [2,3,4,5]

insert 99 [] (insert 1 [2,3,4,5] EmptyDigraph)
	==> 1 -> 2, 1 -> 3, 1 -> 4, 1 -> 5
	    (99)
insert 88 [] (insert 99 [] (insert 1 [2,3,4,5] EmptyDigraph))
	==> 1 -> 2, 1 -> 3, 1 -> 4, 1 -> 5
	    (99) (88)
disconnected (insert 88 [] (insert 99 [] (insert 1 [2,3,4,5] EmptyDigraph)))
	==> [99,88]

Implementation Comments:

- I hate graphs now! (and my life)

- I originally implemented the digraph internally as an adjacency list,
  meaning its representation was a list of nodes, each of which is paired
  with the nodes it is connected to.

  data DigraphNode a = DigraphNode a [a]
  data Digraph a = Digraph [DigraphNode a]

  It was smooth sailing at first, but the `deadend` function seemed almost
  impossible to implement with this representation, so I gave up.

- I had to introduce the dependency of nodes being members of the Eq typeclass
  even though that was not a given precondition. I could not see a different
  way to 'search' for a node within the edges given a node input, which I
  needed to do to implement `deadend` given my representation. Sorry!
-}

data Node a = Node a deriving (Eq)
data Edge a = Edge (Node a) (Node a)
data Digraph a = Digraph [Node a] [Edge a] | EmptyDigraph

instance (Show a) => Show (Node a) where
	show (Node n) = show n

instance (Show a) => Show (Edge a) where
	show (Edge n1 n2) = (show n1) ++ " -> " ++ (show n2)

instance (Show a, Eq a) => Show (Digraph a) where
	show (Digraph [] edges) = ""
	show digraph = strDigraph
		++ (if strDigraph /= "" && strDisconnected /= "" then " " else "")
		++ strDisconnected
		where strDigraph = (showDigraph digraph)
		      strDisconnected = concat (map (\e -> "("++(show e)++") ") (disconnected digraph))

showDigraph :: (Show a) => (Digraph a) -> String
showDigraph (Digraph [] []) = ""
showDigraph (Digraph nodes []) = ""
showDigraph (Digraph [] (edge:edges)) =
	show edge ++ ", " ++ (showDigraph (Digraph [] edges))
showDigraph (Digraph (n:nodes) (e:edges)) =
	show e ++ (if length edges == 0 then "" else ", ")
	++ (showDigraph (Digraph nodes edges))

showEdges (Digraph nodes edges) = edges
showNodes (Digraph nodes edges) = nodes

insert :: Eq a => a -> [a] -> (Digraph a) -> (Digraph a)
insert n ns EmptyDigraph = (Digraph
	(unique ([(Node n)] ++ createNodes ns))
	(createEdges n ns))
insert n ns (Digraph nodes edges) = Digraph
	(unique (nodes ++ [(Node n)] ++ createNodes ns))
	(edges ++ (createEdges n ns))

unique :: Eq a => [a] -> [a]
unique [] = []
unique (x:xs) = if (elem x xs) then unique xs else x:(unique xs)

createNodes :: [a] -> [(Node a)]
createNodes [] = []
createNodes (x:xs) = (Node x):(createNodes xs)

createEdges :: a -> [a] -> [(Edge a)]
createEdges x [] = []
createEdges x (y:ys) = [(Edge (Node x) (Node y))] ++ createEdges x ys

deadend :: Eq a => (Digraph a) -> [Node a]
deadend (Digraph [] []) = []
deadend (Digraph [] edges) = []
deadend (Digraph nodes []) = nodes
deadend (Digraph (node:nodes) edges) =
	if (isDeadend node edges) then node:(deadend (Digraph nodes edges))
	else deadend (Digraph nodes edges)

isDeadend :: Eq a => (Node a) -> [Edge a] -> Bool
isDeadend node [] = True
isDeadend node ((Edge n1 n2):edges) =
	if node == n1 then False
	else isDeadend node edges

disconnected :: Eq a => (Digraph a) -> [Node a]
disconnected (Digraph [] []) = []
disconnected (Digraph [] edges) = []
disconnected (Digraph nodes []) = nodes
disconnected (Digraph (node:nodes) edges) =
	if (isDisconnected node edges)
		then node:(disconnected (Digraph nodes edges))
	else disconnected (Digraph nodes edges)

isDisconnected :: Eq a => (Node a) -> [Edge a] -> Bool
isDisconnected node [] = True
isDisconnected node ((Edge n1 n2):edges) =
	if (node == n1 || node == n2) then False
	else isDisconnected node edges

--  _______ ______  _____ _______ _____
-- |__   __|  ____|/ ____|__   __/ ____|
--    | |  | |__  | (___    | | | (___
--    | |  |  __|  \___ \   | |  \___ \
--    | |  | |____ ____) |  | |  ____) |
--    |_|  |______|_____/   |_| |_____/

test :: (Eq a, Show a) => (Digraph a) -> IO()
test graph = putStr ("Graph: " ++ show graph
	++ " | Dead ends: " ++ show (deadend graph))

-- note: im not including the signature for these trivial functions
--   as it would be a waste of time and space

test1 = test (insert 1 [] EmptyDigraph)
test2 = test (insert 1 [2] EmptyDigraph)
test3 = test (insert 1 [2,3,4,5] EmptyDigraph)
test4 = test (insert 1 [1] EmptyDigraph)
test5 = test (insert 'C' ['D'] (insert 'B' ['C'] (insert 'A' ['B'] EmptyDigraph)))
test6 = test (insert 'D' ['A'] (insert 'C' ['D'] (insert 'B' ['C'] (insert 'A' ['B'] EmptyDigraph))))
test7 = test (insert 'X' [] (insert 'C' ['A'] (insert 'B' ['C'] (insert 'A' ['B'] EmptyDigraph))))
test8 = test (insert 'Z' [] (insert 'Y' [] (insert 'X' [] (insert 'C' ['A'] (insert 'B' ['C'] (insert 'A' ['B'] EmptyDigraph))))))
test9 = test (insert 'Z' [] (insert 'Y' [] (insert 'X' [] (insert 'C' ['D'] (insert 'B' ['C'] (insert 'A' ['B'] EmptyDigraph))))))
test10 = test (insert "abracadabra..." ["alakazam!"] EmptyDigraph)
test11 = test (insert "esr" ["rms"] (insert "rms" ["esr"] (insert "bwk" ["ken", "dmr"] (insert "dmr" ["ken", "bwk"] (insert "ken" ["dmr", "bwk"] EmptyDigraph)))))
test12 = test (insert 3 [] (insert 2 [] (insert 1 [] EmptyDigraph)))
test13 = test (insert 5 [5] (insert 4 [4] (insert 3 [3] (insert 2 [2] (insert 1 [2,3,4,5] EmptyDigraph)))))
test15 = test (insert 20 [1] (insert 19 [20] (insert 18 [19] (insert 17 [18] (insert 16 [17] (insert 15 [16] (insert 14 [15] (insert 13 [14] (insert 12 [13] (insert 11 [12] (insert 10 [11] (insert 9 [10] (insert 8 [9] (insert 7 [8] (insert 6 [7] (insert 5 [6] (insert 4 [5] (insert 3 [4] (insert 2 [3] (insert 1 [2] EmptyDigraph))))))))))))))))))))
