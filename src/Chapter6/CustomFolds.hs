module Chapter6.CustomFolds where

import Control.Lens
import Control.Lens.Lens (lens)
import Control.Lens.Operators
import Control.Lens.Setter
import Control.Lens.TH (makeLenses)
import Control.Lens.Type (Lens)
import qualified Data.Map.Lazy as M
import qualified Data.Set as S
import qualified Data.Text as T

-- folded :: Foldable f => Fold ( f a ) a

-- 1. Fill in each blank with either to , folded , or folding .

cf1 :: String
cf1 = ["Yer" :: String, "a", "wizard", "Harry"] ^.. folded . folded

-- "YerawizardHarry"

cf2 :: [Int]
cf2 = [[1, 2, 3], [4, 5, 6]] ^.. folded . folding (take 2)

-- [ 1 , 2 , 4 , 5 ]

cf3 :: [[Int]]
cf3 = [[1, 2, 3], [4, 5, 6]] ^.. folded . to (take 2)

-- [[ 1 , 2 ], [ 4 , 5 ]]

cf4 :: [String]
cf4 = ["bob", "otto", "hannah"] ^.. folded . to reverse

-- [ "bob" , "otto" , "hannah" ]

cf5 :: String
cf5 = ("abc" :: String, "def") ^.. folding (\(a, b) -> [a, b]) . to reverse . folded

-- "cbafed"

-- 2. Fill in the blank for each of the following expressions with a path of folds which results in the specified answer. Avoid partial functions and fmap .

cf21 :: [Int]
cf21 = [1 .. 5] ^.. folded . to (* 100)

-- [ 100 , 200 , 300 , 400 , 500 ]

cf22 :: [Int]
cf22 = (1, 2) ^.. folding (\(a, b) -> [a, b])

-- [ 1 , 2 ]

cf23 :: [String]
cf23 = [(1, "one"), (2, "two")] ^.. folded . _2

-- [ "one" , "two" ]

cf24 :: [Int]
cf24 = (Just 1, Just 2, Just 3) ^.. each . _Just

-- [ 1 , 2 , 3 ]

cf25 :: [Int]
cf25 = [Left 1, Right 2, Left 3] ^.. folded . folded

-- [ 2 ]

cf26 :: [Int]
cf26 = [([1, 2], [3, 4]), ([5, 6], [7, 8])] ^.. folded . both . folded

-- [ 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 ]

cf27 :: [Either Int Int]
cf27 = [1, 2, 3, 4] ^.. folded . to (\a -> if even a then Right a else Left a)

-- [ Left 1 , Right 2 , Left 3 , Right 4 ]

cf28 :: [Int]
cf28 = [(1, (2, 3)), (4, (5, 6))] ^.. folded . folding (\(a, (b, c)) -> [a, b, c])

-- [ 1 , 2 , 3 , 4 , 5 , 6 ]

cf29 :: [Int]
cf29 = [(Just 1, Left "one"), (Nothing, Right 2)] ^.. folded . folding (\(a, b) -> a ^.. folded <> b ^.. folded)

-- [ 1 , 2 ]

cf210 :: [Either Int String]
cf210 = [(1, "one"), (2, "two")] ^.. folded . to (bimap Left Right) . both

-- [ Left 1 , Right "one" , Left 2 , Right "two" ]

cf211 :: String
cf211 = S.fromList ["apricots", "apples"] ^.. folded . to reverse . folded

-- "selppastocirpa"

-- 3. BONUS – Devise a fold which returns the expected results. Think outside the box a bit.

cf31 :: String
cf31 = [(12, 45, 66), (91, 123, 87)] ^.. folded . _2 . to (reverse . show) . folded

-- "54321"

cf32 :: [String]
cf32 = [(1, "a"), (2, "b"), (3, "c"), (4, "d")] ^.. folded . folding (\(a, b) -> if even a then [b] else [])

-- [ "b" , "d" ]
