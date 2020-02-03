{-# LANGUAGE OverloadedStrings #-}
module Chapter6.Folds where

import           Control.Lens.TH                ( makeLenses )
import           Control.Lens.Type              ( Lens )
import           Control.Lens.Lens              ( lens )
import           Control.Lens
import Control.Lens.Operators
import Control.Lens.Setter
-- import Data.Text

beastSizes :: [(Int, String)]
beastSizes = [(3, "Sirens"), (882, "Kraken"), (92, "Ogopogo")]

bs1 :: [( Int , String )]
bs1 = beastSizes ^.. folded

bs2 :: [String]
bs2 = beastSizes ^.. folded . folded

bs3 :: [Char]
bs3 = beastSizes ^.. folded . folded . folded

tlo1 :: [Int]
tlo1 = toListOf ( folded . folded ) [[ 1 , 2 , 3 ], [ 4 , 5 , 6 ]]

-- other1 :: String
other1 = ( "Hello" , "It's me" ) ^.. both . folded

other2 :: [String]
other2 = ( "Why" , "So" , "Serious?" ) ^.. each

-- quotes :: [( Text , Text , Text )]
-- quotes = [( "Why" , "So" , "Serious?" ), ( "This" , "is" , "SPARTA" )]
