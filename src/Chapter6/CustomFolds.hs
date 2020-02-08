{-# LANGUAGE OverloadedStrings #-}

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

-- 1. Fill in each blank with either to , folded , or folding .

cf1 :: String
cf1 = ["Yer" :: String, "a", "wizard", "Harry"] ^.. folded . folded

-- "YerawizardHarry"

cf2 :: [Int]
cf2 = [[1, 2, 3], [4, 5, 6]] ^.. folded . folding (take 2)
-- [ 1 , 2 , 4 , 5 ]

cf3 :: [[Int]]
cf3 = [[ 1 , 2 , 3 ], [ 4 , 5 , 6 ]] ^.. folded . to ( take 2 )
-- [[ 1 , 2 ], [ 4 , 5 ]]

cf4 :: [String]
cf4 = [ "bob" , "otto" , "hannah" ] ^.. folded . to reverse
-- [ "bob" , "otto" , "hannah" ]

cf5 :: String
cf5 = ( "abc" :: String , "def" ) ^.. folding (\(a , b) -> [ a , b ]) . to reverse . folded
-- "cbafed"

-- 2. Fill in the blank for each of the following expressions with a path of folds which results in the specified answer. Avoid partial functions and fmap .
