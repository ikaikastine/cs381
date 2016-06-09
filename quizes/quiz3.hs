-- Quiz 3
-- Expression Language
data Expr = Zero
          | Succ Expr
          | Sum [Expr]
          | IfZero Expr Expr Expr

sem :: Expr -> Int
sem (Zero) = 0
sem (Succ e) = sem e + 1
--sem (Sum x:xs) = sem x + sem Sum xs

-- Time Language
type Minutes = Int
data Time = Midnight
          | Noon
          | PM Int
          | Before Minutes Time

semT :: Time -> Minutes
semT (Midnight) = 0
semT (Noon) = 720
--semT (PM i) = i
semT (Before m t) = semT t - m
