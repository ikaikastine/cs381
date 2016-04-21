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
vector = Def "vector" ["x1", "y1", "x2", "y2"]
  (Func [Pen Down, MoveTo (N "x1") (N "y1"), MoveTo (N "x2") (N "y2"), Pen Up])

--(c) Define a Haskell function steps :: Int -> Cmd that constructs a Mini Logo
--program which draws a stair of n steps
steps :: Int -> Cmd

steps a | a <= 1 = Func [Call "vector" [0, 0, 0, 1], Call "vector" [0, 1, 1, 1]]
steps a = Func [steps (a-1),
  Func [Call "vector" [a-1, a-1, a-1, a], Call "vector" [a-1, a, a, a]]]

-- Exercise 2. Digital Circuit Design language
--(a) Define the abstract syntax for the above language as a Haskell data type
data Circuit = Circuit Gates Links

data Gates = Gate Int GateFn Gates | GNone

data GateFn = And | Or | Xor | Not deriving Show

data Pair = Pair Int Int

data Links = Link Pair Pair Links | LNone

--(b) Represent the half adder circuit in abstract syntax, that is, as a Haskell
--data type
halfadder = Circuit (Gate 1 Xor
                    (Gate 2 And
                    GNone))

                    (Link (Pair 1 1) (Pair 2 1)
                    (Link (Pair 1 2) (Pair 2 2)
                    LNone))

--(c) Define a Haskell function that implements a pretty printer for the
--abstract syntax
printPair :: Pair -> String
printPair (Pair x y) = show x ++ "." ++ show y

printGateFn :: GateFn -> String
printGateFn And = "and"
printGateFn Or = "or"
printGateFn Xor = "xor"
printGateFn Not = "not"

printGates :: Gates -> String
printGates GNone = ""
printGates (Gate i gatefn gates) = show i ++ ":" ++ show gatefn ++ ";\n"
            ++ printGates gates

printLinks :: Links -> String
printLinks LNone = ""
printLinks (Link pair1 pair2 links) = "from " ++ printPair pair1 ++ " to " ++
          printPair pair2 ++ ";\n" ++ printLinks links

printCircuit :: Circuit -> String
printCircuit (Circuit gates links) = printGates gates ++ printLinks links

-- Exercise 3. Designing Abstract Syntax
--Abstract syntax, changed N to I since it was previously declared above
data Expr = I Int
          | Plus Expr Expr
          | Times Expr Expr
          | Neg Expr

--Alternative abstract syntax
data Op = Add | Multiply | Negate deriving Show

data Exp = Num Int
          | Apply Op [Exp]
          deriving Show

--(a) Represent the expression -(3+4)*7 in the alternative abstract syntax
expression = Apply Multiply [Apply Negate [Apply Add [Num 3, Num 4]], Num 7]

--(b) What are advantanges or disadvantages of either representation?
{-
  Some advantanges of the alternate abstract syntax is that it is more portable
  and has the ability to be used with a variety of different expressions. The
  operator can be applied to an endless number of expressions, thus allowing it
  to be more flexible. In contrast, the first abstract syntax limits the
  expression in terms of what it can do. You can only add two expressions,
  multiply two expressions, or a negate a single expression. With the second
  implementation, you have the freedom to do all three operations with as many
  expressions as you would like.
-}


--(c) Define a function translate :: Expr -> Expr that translates expressions
--given in the first abstract syntax into equivalent expressions in the second
--abstract syntax

{-
translate :: Expr -> Exp
translate (I x) = (Num x)
translate (Plus x y) = Apply Add [translate x, translate y]
translate (Times x y) = Apply Multiply [translate x, translate y]
translate (Neg x) = Apply Negate [translate x]
-}
translate :: Expr -> Exp
translate (I x) = (Num x)
translate (Plus x y) = Apply Add [(translate x), (translate y)]
translate (Times x y) = Apply Multiply [translate x, translate y]
translate (Neg x) = Apply Negate [translate x]
