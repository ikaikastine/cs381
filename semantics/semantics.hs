 -- Kevin Stine
module Semantics where
-- Exercise 1. A Stack Language

{- Consider the stack language S defined by the following grammer
S ::= C | C;S
C ::= LD Int | ADD | MULT | DUP
-}

type Prog = [Cmd]

data Cmd = LD Int
          | ADD
          | MULT
          | DUP
          deriving (Eq, Show)

type Stack = [Int]

type D = Stack -> Maybe Stack

{-prog :: [Cmd] -> Stack -> Maybe Stack
prog ([x]) y = semCmd x y
prog (x:xs) ys = prog xs (semCmd x ys)
prog [] _ = Nothing
-}
sem :: Prog -> Stack -> Maybe Stack
sem ([x]) y = semCmd x y
sem (x:xs) ys = sem xs (unMaybe (semCmd x ys))
sem [] _ = Nothing

semCmd :: Cmd -> Stack -> Maybe Stack
semCmd (LD a) xs = Just ([a] ++ xs)
semCmd (ADD)  (x:y:xs) = Just ((x+y):xs)
semCmd (MULT) (x:y:xs) = Just ((x*y):xs)
semCmd (DUP)  (x:xs) = Just ([x,x] ++ xs)

eval :: Prog -> Stack -> Maybe Stack
eval x [] = sem x []
eval _ _ = Nothing

-- Test data
test1 = [LD 3, DUP, ADD, DUP, MULT] -- [3] -> [3,3] -> [6] -> [6,6] -> Just [36]
test2 = [LD 3, ADD] -- Nothing
test3 = [] -- Just []
test4 = [LD 4, LD 5, ADD]


-- Exercise 2. Extending the Stack Language by Macros
-- (a) Extend the abstract syntax to represent macro definitions and calls,
-- that is, give a correspondingly changed data definition for Cmd.
type Name = String
type Prog2 = [Cmd2]
data Cmd2 = Define Name Prog2
          | Call Name
          | Basic Cmd
          deriving (Eq, Show)

-- (b) Define a new type State to represent the sate for the new language. The
-- state includes the macro definitions and the stack. Please note that a macro
-- definition can be represented by a pair whose first component is the macro
-- name and the second component is the sequence of commands. Multiple macro
-- definitions can be stored in a list. A type to represent macro definitions
-- could thus be defined as follows

type Macros = [(Name, Prog2)]
type State = (Macros, Stack)

dup :: Cmd2
dup = Basic DUP
add :: Cmd2
add = Basic ADD
mult :: Cmd2
mult = Basic MULT
load :: Int -> Cmd2
load n = Basic (LD n)

-- Macro to calculate the square of a number of the argument on the stack
sqr :: Cmd2
sqr = Define "square" [dup,mult]

-- Macro to double the argument on the top of the stack
double :: Cmd2
double = Define "double" [dup,add]

-- (c) Define the semantics for the extended language as a function sem2. As in
-- exercise 1, you probably want to define an auxilary function semCmd2 for the
-- semantics of individual operations.
sem2 :: Prog2 -> State -> Maybe State
sem2 ([x]) y = semCmd2 x y
sem2 (x:xs) ys = sem2 xs (unMaybe (semCmd2 x ys))
sem2 [] _ = Nothing

semCmd2 :: Cmd2 -> State -> Maybe State
semCmd2 (Basic c) (m, s) = Just (m, unMaybe(semCmd c s))
semCmd2 (Define n p) (m,s) = Just (m ++ [(n,p)], s)
semCmd2 (Call n) (m,s) = sem2 (unMaybe (lookup n m)) (m,s)

unMaybe :: Maybe t -> t
unMaybe (Just x) = x
unMaybe (Nothing) = undefined

evalMacro :: Prog2 -> Maybe Stack
evalMacro x = Just (snd (unMaybe (sem2 x ([],[]))))

macroTest1 = [sqr, load 5, sqr, Call "square"] -- Just [25]
macroTest2 = [double, load 22, double, Call "double"] -- Just [44]

-- Exercise 3. Mini Logo
data Cmd3 = Pen Mode
          | MoveTo Int Int
          | Seq Cmd3 Cmd3
          deriving (Eq, Show)

data Mode = Up | Down
          deriving (Eq, Show)

type State2 = (Mode, Int, Int)
type Line = (Int, Int, Int, Int)
type Lines = [Line]

semS :: Cmd3 -> State2 -> (State2, Lines)

semS (Pen m1) s@(m2, x, y) | m1 /= m2 = ((m1, x, y), [])
                           | otherwise = (s, [])

semS (MoveTo x1 y1) (m, x2, y2) | m == Up = (ns, [])
                                | x1 /= x2 && y1 /= y2 = (ns, [(x2, y2, x1, y1)])
                                | otherwise = (ns, [])
                                where ns = (m, x1, y1)

semS (Seq a b) s = (fst s2, snd s1 ++ snd s2) where
                  s1 = semS a s
                  s2 = semS b (fst s1)

sinit = (Up, 0, 0)

sem' :: Cmd3 -> Lines

sem' a = snd (semS a sinit)

moveTest1 = Pen Down `Seq` MoveTo 1 1
semTest1 = sem' moveTest1 -- [(0, 0, 1, 1)]
moveTest2 = Pen Down `Seq` MoveTo 2 4 `Seq` MoveTo 3 5
semTest2 = sem' moveTest2 -- [(0, 0, 2, 4), (2, 4, 3, 5)]
