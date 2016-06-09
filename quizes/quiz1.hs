xs = [1,2,3]
ys = [4,5]
zs = [6]
ll = [xs,ys,zs]

{-
(a) (head ys):(tail xs)
    [4,2,3]

    calculates head ys = 4 -> tail xs = [2,3] -> concatenates them

(b) map head ll
    [1,4,6]

    grabs the head of each element in ll and maps it to a new list

(c) (head . tail) ll
    [4,5]

    calculates tail ll first = [[4,5],[6]] -> then calculates head of
    that result = [4,5]

(d) (tail . head) ll
    [2,3]

    calculates head ll first = xs = [1,2,3] -> calculates tail = [2,3]

(e) map tail (tail ll)
    [[5],[]]

    calculates tail ll first = [[4,5], [6]] -> maps the tail of each
    element listed to a new list = [[5],[]] since the last element
    of the second list is empty, resulting in an empty list

(f) reverse (tail ll)
    [[6],[4,5]]

    calculates tail ll first = [[4,5],[6]] -> reverses the order
    = [[6],[4,5]]

(g) map reverse ll
    [[3,2,1],[5,4],[6]]

    maps to a new list by reversing each of the sublists within the main
    list
-}

-- Function Definitions
-- (a) Give a Haskell function definitino for maxList
maxList :: [Int] -> Int
maxList [] = error "max of empty list"
maxList [x] = x
maxList (x:xs) = max x (maxList xs)
-- (b) Using maxList, given an expression that computes the largest
-- element of a nested list of non-negative integers ll (of type
-- [[Int]]), as definied in question 1

-- This functino takes a list, and iterates through the list until it
-- has a pair, then returns the first value of the pair
f [x,y] = x
f (x:xs) = f xs

-- This function essentially does the tail function. It removes the
-- first element from the list and returns the rest of the list
g (x:(y:xs)) = y:(g (x:xs))
g [x] = []
g [] = []
