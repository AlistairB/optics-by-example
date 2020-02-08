{-# LANGUAGE OverloadedStrings #-}
module Chapter6.Folds where

import           Control.Lens.TH                ( makeLenses )
import           Control.Lens.Type              ( Lens )
import           Control.Lens.Lens              ( lens )
import           Control.Lens
import Control.Lens.Operators
import Control.Lens.Setter
import Data.Text
import Data.Set as S
import Data.Map.Lazy as M

-- 1.

-- folded :: Foldable f => Fold ( f a ) a

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

other1 :: String
other1 = ( "Hello" :: String, "It's me" ) ^.. both . folded

other2 :: [String]
other2 = ( "Why" , "So" , "Serious?" ) ^.. each

quotes :: [( Text , Text , Text )]
quotes = [( "Why" , "So" , "Serious?" ), ( "This" , "is" , "SPARTA" )]

quotes1 :: String
quotes1 = quotes ^.. each . each . each

-- 2. Write out the ‘specialized’ type for each of the requested combinators used in each of the following expressions.

-- folded and _1

two1 :: [Int]
two1 = toListOf ( folded . _1 ) [( 1 , 'a' ), ( 2 , 'b' ), ( 3 , 'c' )]
-- [ 1 , 2 , 3 ]

-- folded :: Fold [(Int, Char)] (Int, Char)
-- _1 :: Lens (Int, Char) Char Char Char

-- folded :: Fold [( Int , Char )] ( Int , Char )
-- _1 :: Fold ( Int , Char ) Int

-- folded , _2 , and toListOf

two2 :: [String]
two2 = toListOf ( _2 . folded ) ( False , S.fromList [ "one" , "two" , "three" ])
-- [ "one" , "two" , "three" ]

-- _2 :: Fold (Bool, S.Map String) (S.Set String)
-- folded :: Fold (S.Map String) String
-- toListOf :: Fold (Bool, S.Map String) String -> (Bool, S.Map String) -> [String]

-- folded and folded and toListOf

two3 :: String
two3 = toListOf ( folded . folded ) ( M.fromList [( "Jack" , "Captain" :: String ), ( "Will" , "First Mate" )])
-- "CaptainFirst Mate"


-- folded :: Fold (M.Map String String) String
-- folded :: Fold String Char
-- toListOf :: Fold (M.Map String) Char -> (M.Map String String) -> String


-- 3.

three1 = [ 1 , 2 , 3 ] ^.. folded
-- [ 1 , 2 , 3 ]

three2 = ( "Light" , "Dark" ) ^.. _1
-- [ "Light" ]

three3 = [( "Light" , "Dark" ), ( "Happy" , "Sad" )] ^.. folded . each
-- [ "Light" , "Dark" , "Happy" , "Sad" ]

three4 = [( "Light" , "Dark" :: String ), ( "Happy" , "Sad" )] ^.. folded . _2 . folded
-- "DarkSad"
