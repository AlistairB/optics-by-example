module Chapter6.HigherOrderFolds where

import Control.Lens
import Control.Lens.Lens (lens)
import Control.Lens.Operators
import Control.Lens.Setter
import Control.Lens.TH (makeLenses)
import Control.Lens.Type (Lens)
import qualified Data.Map.Lazy as M
import qualified Data.Set as S
import qualified Data.Text as T
import Data.Char
import Data.Function

-- 1. Fill in the blank. You’ll need to remember some tricks from previous sections!

hof1 :: String
hof1 = "Here's looking at you, kid" ^.. dropping 7 folded
-- "looking at you, kid"

hof2 :: [String]
hof2 = [ "My Precious" , "Hakuna Matata" , "No problemo" ] ^.. folded . taking 1 worded
-- [ "My" , "Hakuna" , "No" ]

hof3 :: [String]
hof3 = [ "My Precious" , "Hakuna Matata" , "No problemo" ] ^.. taking 1 (folded . worded)
-- [ "My" ]

hof4 :: String
hof4 = [ "My Precious" , "Hakuna Matata" , "No problemo" ] ^.. folded . taking 1 worded . folded

hof5 :: Int
hof5 = sumOf (taking 2 each) ( 10 :: Int , 50 :: Int , 100 )
-- 60
hof6 :: [String]
hof6 = ( "stressed" , "guns" , "evil" ) ^.. backwards each
-- [ "evil" , "guns" , "stressed" ]

hof7 :: [String]
hof7 = ( "stressed" , "guns" , "evil" ) ^.. backwards each . to reverse
-- [ "live" , "snug" , "desserts" ]

hof8 :: String
hof8 = "blink182 k9 blazeit420" ^.. worded . droppingWhile isAlpha folded
-- "1829420"

-- 2.

sample :: [ Int ]
sample = [ -10 , -5 , 4 , 3 , 8 , 6 , -2 , 3 , -5 , -7 ]

numDaysFirstThaw :: Int
numDaysFirstThaw = lengthOf (takingWhile (< 0) folded) sample
-- 2

warmestInFirst4Days :: Maybe Int
warmestInFirst4Days = maximumOf (taking 4 folded) sample
-- Just 4

nextDayAfter :: Maybe Int
nextDayAfter = sample ^? dropping 1 (droppingWhile (/= 4) folded)
--Just 3

howManyFreezingAtEnd :: Int
howManyFreezingAtEnd = lengthOf (takingWhile (<= 0) (backwards folded)) sample
-- 2

fromFirstThawToNextFreeze :: [Int]
fromFirstThawToNextFreeze = sample ^.. (takingWhile (> 0) . droppingWhile (<= 0)) folded
-- [ 4 , 3 , 8 , 6 ]

fromFirstThawToLastFreeze :: [Int]
fromFirstThawToLastFreeze = sample ^.. trimmingWhile (<= 0) folded
-- [ 4 , 3 , 8 , 6 , - 2 , 3 ]

trimmingWhile :: ( a -> Bool ) -> Fold s a -> Fold s a
trimmingWhile p = backwards . droppingWhile p . backwards . droppingWhile p
