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
          deriving Show

type Stack = [Int]

type D = Maybe Stack -> Maybe Stack

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
data Cmd2 = C Cmd
          | DEF String Prog
          | CALL String
          deriving Show

type Prog2 = [Cmd2]

-- (b) Define a new type State to represent the sate for the new language. The
-- state includes the macro definitions and the stack. Please note that a macro
-- definition can be represented by a pair whose first component is the macro
-- name and the second component is the sequence of commands. Multiple macro
-- definitions can be stored in a list. A type to represent macro definitions
-- could thus be defined as follows

type Macros = [(String, Prog)]
type State = (Macros, Maybe Stack)

-- (c) Define the semantics for the extended language as a function sem2. As in
-- exercise 1, you probably want to define an auxilary function semCmd2 for the
-- semantics of individual operations.
sem2 :: Prog2 -> E
sem2 [] a = a
sem2 (x:xs) a = sem2 xs (semCmd2 x a)

semCmd2 :: Cmd2 -> E
semCmd2 (C c) (m, st) = m, semCmd (C c) st
semCmd2 (DEF cmd p) (m, st) = [(cmd, p)] ++ m, st
semCmd2 (CALL cmd) (m, st) = semCmd2 cmd (m, st)
semCmd2 c          (m, st) = (m, map semCmd2 nCmd)
                            where nCmd = snd (c, prog):m 

-- Exercise 3. Mini Logo
data Cmd = Pen Mode
         | MoveTo Int Int
         | Seq Cmd Cmd

data Mode = Up | Down

type State = (Mode, Int, Int)

type Line = (Int, Int, Int, Int)
type Lines = [Line]

semS :: Cmd -> State -> (State, Lines)

sem' :: Cmd -> Lines
