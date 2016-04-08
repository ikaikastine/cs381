-- Exercise 1. Mini Logo
--(a) Define the abstract syntax for Mini Logo as a Haskell data type

type Name = String
type Num = Int

data Pos = PO Num | PS Name deriving Show
--data PenPos = (Pos, Pos)

--data Pars = Parse [Name] deriving Show
type Pars = [String]
--data Vals = Values [Name] deriving Show
type Vals = [Int]
data Mode = Up | Down deriving Show

data Cmd = Pen Mode
          | MoveTo (Pos, Pos)
          | Def Name Pars Cmds
          | Call Name Vals
          deriving Show
type Cmds = [Cmd]

--(b) Write a Mini Logo macro vector that draws a line from a given position
--(x1,y1) to a given position (x2, y2) and represent the macro in the abstract
--syntax, that is, as a Haskell data type value.

--Abstract Syntax:
vector = Def "vector" [x1, y1, x2, y2] [Pen Up, MoveTo (x1, y1), Pen Down, MoveTo (x2, y2)]
callVec = Call "vector" [1,1,2,2]

-- Exercise 2. Digital Circuit Design language







-- Exercise 3. Designing Abstract Syntax
