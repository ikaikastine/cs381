-- Expression Semantics
data Expr = N Int
          | Plus Expr Expr
          | Neg Expr
          deriving Show

sem :: Expr -> Int
sem (N i)       = i
sem (Plus e e') = sem e + sem e'
sem (Neg e)     = -(sem e)

-- Abstract Syntax Exercises
data Dir = Lft | Rgt | Up | Dwn
data Step = Go Dir Int
type Move = [Step]

-- (1) Give a type definition for the data type step
type Step = (Dir,Int)
-- (2) Define the data type Move without using built-in lists
data Move = One Step
          | Seq Step Move
-- (3) Write the move [Go Up 3, Go Rght 4, Go Dwn 1]
move341 = (Up 3) `Seq` (Rgt 4) `Seq` One (Dwn 1)
