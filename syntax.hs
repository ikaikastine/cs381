-- Exercise 1. Mini Logo
--(a) Define the abstract syntax for Mini Logo as a Haskell data type

type Name = String
type Numb = Int

data Pos = PO Numb | PS Name deriving Show
data PenPos = PP (Pos, Pos)

data Pars = Parse [Name] deriving Show
--type Pars = [String]
data Vals = Values [Name] deriving Show
--type Vals = [Int]
data Mode = Up | Down deriving Show

data Cmd = Pen Mode
          | MoveTo PenPos
          | Def Name Pars Cmds
          | Call Name Vals
          --deriving Show
type Cmds = [Cmd]

--(b) Write a Mini Logo macro vector that draws a line from a given position
--(x1,y1) to a given position (x2, y2) and represent the macro in the abstract
--syntax, that is, as a Haskell data type value.

--Abstract Syntax:
vector = Def "vector" (Parse ["x1", "y1", "x2", "y2"]) [Pen Up, MoveTo (Parse "x1", Parse "y1"), Pen Down, MoveTo (Parse "x2", Parse "y2")]
callVec = Call "vector" [1,1,2,2]

-- Exercise 2. Digital Circuit Design language







-- Exercise 3. Designing Abstract Syntax
