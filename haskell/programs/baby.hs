-- experimenting in the REPL while following learnyouahaskell

doubleMe a = a + a
doubleUs x y = doubleMe x + doubleMe y
doubleSmallNumber x = if x > 100 then x else doubleMe x
doubleSmallNumber' a = (if a > 100 then a else doubleMe a) + 1
jeff = "My nama jeff :P"
nums = [2, 4, 8, 16, 32]
nums2 = [2.0, 3, 4.0, 5]
chars = ['a', 'b', 'c']
