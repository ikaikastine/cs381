-- Kevin Stine
module Types where
-- Exercise 1. A Rank-Based Type Systems for the Stack Language
type Prog = [Cmd]

data Cmd = LD Int
         | ADD
         | MULT
         | DUP
         | INC
         | SWAP
         | POP Int

type Stack = [Int]
type D = Stack -> Stack

-- (a) Use the following types to represent stack and operation ranks
type Rank = Int
type CmdRank = (Int, Int)

semCmd :: Cmd -> D
semCmd (LD a) xs         = [a] ++ xs
semCmd (ADD) (x1:x2:xs)  = [x1+x2] ++ xs
semCmd (MULT) (x1:x2:xs) = [x1*x2] ++ xs
semCmd (DUP) (x1:xs)     = [x1,x1] ++ xs
semCmd (INC) (x1:xs)     = [succ x1] ++ xs
semCmd (SWAP) (x1:x2:xs) = (x2:x1:xs)
semCmd (POP n) xs        = drop n xs
semCmd _ _               = []

sem :: Prog -> D
sem [] a     = a
sem (x:xs) a = sem xs (semCmd x a)

rankC :: Cmd -> CmdRank
rankC (LD _)  = (0, 1)
rankC ADD     = (2, 1)
rankC MULT    = (2, 1)
rankC DUP     = (1, 2)
rankC INC     = (1, 1)
rankC SWAP    = (2, 2)
rankC (POP a) = (a, 0)

rankP :: Prog -> Maybe Rank
rankP xs = rank xs 0

rank :: Prog -> Rank -> Maybe Rank
rank [] r | r >= 0          = Just r
rank (x:xs) r | under >= 0  = rank xs (under + adds) where
  (subs, adds)              = rankC x
  under                     = r - subs
rank _ _                    = Nothing

-- (b) Following the example of the function evalSTatTC (defined in the file)
-- TypeCheck.hs), define a function semStatTC for evaluating stack programs
-- that first calls the function rankP to check whether the stack program
-- is type correct and evaluates the program only in that case. For performing
-- the actual evaluation semStatTC calls the function sem.

data Type = A Stack | TypeError deriving Show

typeSafe :: Prog -> Bool
typeSafe p = (rankP p) /= Nothing

semStatTC :: Prog -> Type
semStatTC p | typeSafe p = A (sem p [])
            | otherwise = TypeError

{-
  What is the new type of the function sem and why can the function definition
  be simplified to have this type?

  The new type of sem is Prog -> D. D = Stack -> Stack. Type D can be
  simplified to no longer contain Maybe Stacks, because the type checker
  handles all TypeErrors
-}

-- Exercise 2. Shape Language

data Shape = x
           | TD Shape Shape
           | LR Shape Shape
           deriving Show

type BBox = (Int, Int)

-- (a) Define a type checker for the shape language as a Haskell function

bbox :: Shape -> BBox
bbox (TD i j) | ix >= jx = (ix, iy + jy)
              | ix < jx = (jx, iy + jy)
              where (ix, iy) = bbox i
                    (jx, jy) = bbox j

bbox (LR i j) | iy >= jy = (ix + jy, iy)
              | iy < jy = (ix + jx, jy)
              where (ix, iy) = bbox i
                    (jx, jy) = bbox j

bbox X = (1, 1)

-- (b) Rectangles are a subset of shapes and thus describe a more restricted
-- set of types. By restricting the applciation of the TD and LR operations to
-- rectangles only one could ensure that only convex shapes without holes can
-- be constructed. Define a type checker for the shape langugage that assigns
-- types only to rectangular shapes by defining a Haskell function

rect :: Shape -> Maybe BBox
rect X = Just (1, 1)
rect (TD i j) = case rect i of
  Nothing -> Nothing Just (ix, iy) -> case rect j of
    Nothing -> Nothing Just (jx, jy) -> case (ix == jx) of
      True -> Just (ix, oy + jy)
      False -> Nothing
rect (LR i j) = case rect i of
  Nothing -> Nothing Just (ix, iy) -> case rect j of
    Nothing -> Nothing Just (jx, jy) -> case (iy == jy) of
      True -> Just (ix + jx, iy)
      False -> Nothing



-- Exercise 3. Parametric Polymorphism
-- (a) Consider the functions f and g, which are given by the following two
-- function definitions.

-- TODO: all of exercise 3

{-
f x y = if null x then [y] else x
g x y = if not (null x) then [] else [y]

(1) What are the types of f and g?



(2) Explain why the functions have these types.



(3) Which type is more general?




(4) Why do f and g have different types?



-}

-- (b) Find a (simple) definition for a function h that has the following type
h :: [b] -> [(a, b)] -> [b]




-- (c) Find a (simple) definition for a function k that has the following type
k :: (a -> b) -> ((a -> b) -> a) -> b


-- (d) Can you define a function of type a -> b? If yes, explain your
-- definition. If not, explain why it is so difficult.
