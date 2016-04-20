import Prelude hiding (Num)
-- Exercise 1. Mini Logo
--(a) Define the abstract syntax for Mini Logo as a Haskell data type

data Cmd = Pen Mode
          | MoveTo Pos Pos
          | Def Name Pars Cmd
          | Call Name Vals
          | Func [Cmd]
          deriving Show

data Mode = Up | Down deriving Show

data Pos = M Num | N Name deriving Show

type Pars = [Name]

type Vals = [Num]

type Name = String
type Num = Int

--(b) Write a Mini Logo macro vector that draws a line from a given position
--(x1, y1) to a given position (x2, y2) and represent the macro in the abstract
--syntax, that is, as a Haskell data type value.

--Abstract Syntax:
vector = Def "vector" ["x1", "y1", "x2", "y2"] (Func [Pen Down, MoveTo (N "x1") (N "y1"), MoveTo (N "x2") (N "y2"), Pen Up])
--vector = Def "vector" ["x1", "y1", "x2", "y2"] Func [ Pen Down, MoveTo("x1", "y1"), MoveTo("x2", "y2"), Pen Up]
--(c) Define a Haskell function steps :: Int -> Cmd that constructs a Mini Logo
--program which draws a stair of n steps

-- Exercise 2. Digital Circuit Design language







-- Exercise 3. Designing Abstract Syntax
