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

-- (3) Derive the sentence 101

-- (4) Write a grammer for bolean expression built from constants T and F and
-- the operation not

-- (5) Derive the sentence not not F
