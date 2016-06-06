-- (1) Extend the "sentence" grammer to allow the creation of "and" sentences
data Sentence = Phrase Noun Verb Noun
              | And Sentence Sentence
              deriving Show
data Noun = Dogs | Teeth deriving Show
data Verb = Have deriving Show

s1 :: Sentence
s1 = Phrase Dogs Have Teeth

s2 :: Sentence
s2 = Phrase Teeth Have Dogs

s3 :: Sentence
s3 = And s1 s2
-- (2) Write a grammer for binary numbers
data Digit = One | Zero
           deriving Show

data Bin = D Digit
         | B Digit Bin
         deriving Show

-- (3) Derive the sentence 101
l0l :: Bin
l0l = B One (B Zero (D One))

-- (4) Write a grammer for bolean expression built from constants T and F and
-- the operation not
data BoolExpr = T | F | Not BoolExpr
              deriving Show

nnt :: BoolExpr
nnt = Not (Not T)

-- (5) Derive the sentence not not F
nnf :: BoolExpr
nnf = Not (Not F)

-- ABSTRACT SYNTAX
-- (1) Define abstract syntax for the following grammer
{-
  con ::= 0 | 1
  reg ::= A | B | C
  op ::= MOV con TO reg
       | MOV reg To Reg
       | INC reg BY con
       | INC reg BY reg
-}
data Con = Int
data Reg = A | B | C deriving (Eq, Show)
data Op = MOVC Con Reg
        | MOVR Reg Reg
        | INCC Reg Con
        | INCR Reg Reg

-- (2) Refactor grammer and abstract syntax by introducing a nonterminal to
-- represent a con or a reg
data ConOrReg = X Con | R Reg
              deriving (Eq, Show)

data Op' = MOV ConOrReg Reg
         | INC Reg ConOrReg
         deriving (Eq, Show)
