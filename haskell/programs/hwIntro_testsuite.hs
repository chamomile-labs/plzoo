listAfterKey [1,2,3,4,5] 1 == [2,3,4,5]
listAfterKey [1,2,3,4,5] 5 == []
listAfterKey [1,2,3,4,5] 7 == []
listAfterKey [] 1 == []
listAfterKey [1..999] 998 == [999]

startStrings ["a", "square", "is", "a", "rectangle"] 'a' == ["a", "a"]
startStrings ["a", "square", "is", "a", "rectangle"] 's' == ["square"]
startStrings ["a", "square", "is", "a", "rectangle"] 'z' == []
startStrings ["tis", "nobler", "in", "the", "mind", "to", "suffer", "the", "slings", "and", "arrows"] 's' == ["suffer", "slings"]
startStrings [] 'z' == []

merge [1,3,5] [2,4,6] == [1,2,3,4,5,6]
merge [1] [2] == [1,2]
merge [] [] == []

mergepad [1,3,5] [2,4,6,8] == [1,2,3,4,5,6,1,8]
mergepad [1] [9, 10, 11, 12, 13] == [1,9,1,10,1,11,1,12,1,13]
mergepad [] [] == []
mergepad [1] [] == [1,1]
mergepad [1,2,3] [] == [1,1,2,1,3,1]
mergepad [] [1,2,3] == []

pointsInCircle 0 == []
pointsInCircle 1 == []
pointsInCircle 2 == [(1,1)]
pointsInCircle 3 == [(1,1),(1,2),(2,1),(2,2)]
pointsInCircle 4 == [(1,1),(1,2),(1,3),(2,1),(2,2),(2,3),(3,1),(3,2)]
pointsInCircle 5 == [(1,1),(1,2),(1,3),(1,4),(2,1),(2,2),(2,3),(2,4),(3,1),(3,2),(3,3),(4,1),(4,2)]

cyclicn (\n->(mod (n+3) 7)) 5 9 == True
cyclicn (\n->(mod (n+3) 7)) 5 6 == False
cyclicn (+1) 5 9 == False
cyclicn (+0) 5 9 == True
cyclicn (*1) 5 9 == True

evenSquares [] == []
evenSquares [1] == []
evenSquares [2] == [4]
evenSquares [1,2,3] == [4]
evenSquares [1,3,9,9,9] == []
evenSquares [2,4,6,8] == [4,16,36,64]

startStringsHOF ["a", "square", "is", "a", "rectangle"] 'a' == ["a", "a"]
startStringsHOF ["a", "square", "is", "a", "rectangle"] 's' == ["square"]
startStringsHOF ["a", "square", "is", "a", "rectangle"] 'z' == []
startStringsHOF ["tis", "nobler", "in", "the", "mind", "to", "suffer", "the", "slings", "and", "arrows"] 's' == ["suffer", "slings"]
startStringsHOF [] 'z' == []

freq "" 'a' == 0
freq "abc" 'a' == 1
freq "abc" 'z' == 0
freq "AaBbAaCcDdA" 'a' == 2
freq "AaBbAaCcDdA" 'A' == 3
freq "Hello world - Brian Kernighan" ' ' == 4

