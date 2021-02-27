-- note: Int will overflow, Integer will not as it has infinite precision

-- Direct Way
factd:: Int -> Int -- signature
factd n =
	if (n <= 0) then 1
	else n * (factd (n - 1))

-- Pattern matching (on arguments) (like def by cases)
factpm:: Int -> Int
factpm 0 = 1
factpm n = n * (factpm (n - 1))

-- Guards (top to bottom)
factg:: Int -> Int
factg n | (n <= 0) = 1
	| (n == 1) = 1
	| otherwise = n * (factg (n - 1))

-- Combination of guards and pattern matching
factgp:: Int -> Int
factgp 0 = 1
factgp n | (n == 1) = 1
	 | otherwise = n * (factgp (n-1))
