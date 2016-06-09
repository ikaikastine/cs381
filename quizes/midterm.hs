-- Midterm
-- (1) Haskell
data Tree = Node Int Tree Tree
          | Empty


-- (2) Abstract Syntax
data Type = Int | Bool | Char
data Decl = PS Type Name Pars Stmt
data Pars = TN Type Name Pars | EmptyType
