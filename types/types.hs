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

data Shape = X
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
  Nothing -> Nothing
  Just (ix, iy) -> case rect j of
    Nothing -> Nothing
    Just (jx, jy) -> case (ix == jx) of
      True -> Just (ix, iy + jy)
      False -> Nothing
rect (LR i j) = case rect i of
  Nothing -> Nothing
  Just (ix, iy) -> case rect j of
    Nothing -> Nothing
    Just (jx, jy) -> case (iy == jy) of
      True -> Just (ix + jx, iy)
      False -> Nothing

-- Exercise 3. Parametric Polymorphism
-- (a) Consider the functions f and g, which are given by the following two
-- function definitions.

-- TODO: all of exercise 3

f x y = if null x then [y] else x
g x y = if not (null x) then [] else [y]

{-
(1) What are the types of f and g?

  f :: [t] -> t -> [t]
  g :: Flodable t => t a -> t1 -> [t1]

(2) Explain why the functions have these types.

  The function f returns x or [y], however since x is a list, both x and y have
  to have the same type which is a list.

  The function g returns either an empty list [] or [y], however in this
  instance, x and y have no relation since the function will not return x.

(3) Which type is more general?

  Both f and g are designed to work with any type, however since g can work
  with more than one type, it is more general.

(4) Why do f and g have different types?

  They are different because of the Haskell type inference which means that
  concrete types are deduced by the type system wherever it is obvious.
-}

-- (b) Find a (simple) definition for a function h that has the following type
h :: [b] -> [(a, b)] -> [b]
h b _ = b

-- (c) Find a (simple) definition for a function k that has the following type
-- k :: (a -> b) -> ((a -> b) -> a) -> b
  {-
    I could not figure out a simple definiton for function k. Since b is the
    return type of another function, I'm not sure how to define a function that
    would use b from that return type.
  -}

-- (d) Can you define a function of type a -> b? If yes, explain your
-- definition. If not, explain why it is so difficult.
  {-
    I cannot define a function of type a -> b due to the fact that I don't know
    anything about type b. What this function could be used for is converting
    a value from any type to another type, however it would mean that you need
    to ensure that the old and new types have identical internal
    representations to prevent runtime corruption. To define a function like
    this, I would need to know the internal representations of both types.
  }
