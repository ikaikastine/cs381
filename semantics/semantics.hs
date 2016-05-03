 -- Kevin Stine

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

type D = Maybe Stack -> Maybe Stack

{-prog :: [Cmd] -> Stack -> Maybe Stack
prog ([x]) y = semCmd x y
prog (x:xs) ys = prog xs (semCmd x ys)
prog [] _ = Nothing
-}
sem :: Prog -> D
sem [] a = a
sem (x:xs) a = sem xs (semCmd x a)

semCmd :: Cmd -> D
semCmd (LD a) xs = case xs of Just xs         -> Just ([a] ++ xs)
                              _               -> Nothing
semCmd (ADD)  xs = case xs of Just (x1:x2:xs) -> Just ([x1+x2] ++ xs)
                              _               -> Nothing
semCmd (MULT) xs = case xs of Just (x1:x2:xs) -> Just ([x1*x2] ++ xs)
                              _               -> Nothing
semCmd (DUP)  xs = case xs of Just (x1:xs)    -> Just ([x1,x1] ++ xs)
                              _               -> Nothing
eval :: Prog -> Maybe Stack
eval p = sem p (Just [])

-- Test data
test1 = [LD 3, DUP, ADD, DUP, MULT] -- [3] -> [3,3] -> [6] -> [6,6] -> Just [36]
test2 = [LD 3, ADD] -- Nothing
test3 = [] -- Just []


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
type State = (Macros, Maybe Stack)

-- (c) Define the semantics for the extended language as a function sem2. As in
-- exercise 1, you probably want to define an auxilary function semCmd2 for the
-- semantics of individual operations.
sem2 :: Prog2 -> State -> Maybe State
sem2 [] _ = Nothing
sem2 ([x]) y = semCmd2 x y
sem2 (p:ps) s = sem2 ps (Maybe (semCmd2 p s))

semCmd2 :: Cmd2 -> State -> Maybe State
semCmd2 (Basic c) (m, s) = Just (m, semCmd c s)
semCmd2 (Define n p) (m,s) = Just (m ++ [(n,p)], s)
semCmd2 (Call n) (m,s) = sem2 (lookup n m) (m,s)



--eval2 :: ProgMacro -> Macros
--eval2 p = sem2 p (Just [])

--macroTest1 = [Define "foo" [DUP, ADD, MULT]] -- [("foo", [DUP, ADD, MULT])]

-- Exercise 3. Mini Logo
{-
data Cmd = Pen Mode
         | MoveTo Int Int
         | Seq Cmd Cmd

data Mode = Up | Down

type State = (Mode, Int, Int)

type Line = (Int, Int, Int, Int)
type Lines = [Line]

semS :: Cmd -> State -> (State, Lines)

sem' :: Cmd -> Lines
-}
