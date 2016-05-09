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
