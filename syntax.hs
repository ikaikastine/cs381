import Prelude hiding (Num)
-- Exercise 1. Mini Logo
--(a) Define the abstract syntax for Mini Logo as a Haskell data type

data Cmd = Pen Mode
          | MoveTo Pos Pos
          | Def Name Pars Cmd
          | Call Name Vals
          | Seq [Cmd]
          deriving Show

data Mode = Up | Down

data Pos = M Num | N Name

type Pars = [Name]

type Vals = [Num]

type Name = String

type Num = Int

instance Show Mode where
  show Up = "up"
  show Down = "down"

instance Show Pos where
  show (M a) = show a

--(b) Write a Mini Logo macro vector that draws a line from a given position
--(x1,y1) to a given position (x2, y2) and represent the macro in the abstract
--syntax, that is, as a Haskell data type value.

--Abstract Syntax:

-- Exercise 2. Digital Circuit Design language







-- Exercise 3. Designing Abstract Syntax
