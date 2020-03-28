module Chapter6.FoldActions where

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

-- 1. Pick the matching action from the list for each example:

six11 :: Bool
six11 = has folded []
-- False

six12 :: String
six12 = foldOf both ( "Yo" , "Adrian!" )
-- "YoAdrian!"

six13 :: Bool
six13 = elemOf each "phone" ( "E.T." , "phone" , "home" )
-- True

six14 :: Maybe Int
six14 = minimumOf folded [ 5 , 7 , 2 , 3 , 13 , 17 , 11 ]

six15 :: Maybe Int
six15 = minimumOf folded [ 5 , 7 , 2 , 3 , 13 , 17 , 11 ]

six16 :: Maybe Int
six16 = lastOf folded [ 5 , 7 , 2 , 3 , 13 , 17 , 11 ]

six17 :: Bool
six17 =  anyOf folded (( > 9 ) . length ) [ "Bulbasaur" , "Charmander" , "Squirtle" ]
-- True

six18 :: Maybe Int
six18 = findOf folded even [ 11 , 22 , 3 , 5 , 6 ]
-- Just 22

-- 2. Use an action from the list along with any fold you can devise to retrieve the output from the input in each of the following challenges. There may be more than one correct answer. Find the first word in the input list which is a palindrome; I.e. a word that’s the same backwards as forwards.

six21 :: Maybe String
six21 = findOf folded isPalindrome [ "umbrella" , "olives" , "racecar" , "hammer" ]
  where
    isPalindrome a = a == reverse a

six22 :: Bool
six22 = allOf each even ( 2 , 4 , 6 )

six23 :: Maybe (Int, String)
six23 = maximumByOf folded (compare `on` fst) [( 2 , "I'll" ), ( 3 , "Be" ), ( 1 , "Back" )]

six24 :: Maybe (Int, String)
six24 = maximumByOf folded (compare `on` fst) [( 2 , "I'll" ), ( 3 , "Be" ), ( 1 , "Back" )]

six25 :: Int
six25 = sumOf both (1, 2)

six26 :: Maybe String
six26 = maximumByOf worded (compare `on` countVowels) "Do or do not, there is no try."
  where
    countVowels = length . filter (`elem` "aeiou") . fmap toLower

six27 :: String
six27 = foldByOf folded (flip (++)) [] [ "a" , "b" , "c" ]

six28 :: String
six28 = [( 12 , 45 , 66 ), ( 91 , 123 , 87 )] ^.. folded . _2 . to show . to reverse . folded
-- "54321"

six29 :: [String]
six29 = foldrOf folded includeSndIfEven [] [( 1 , "a" ), ( 2 , "b" ), ( 3 , "c" ), ( 4 , "d" )]
  where
    includeSndIfEven (a, b) r = if even a then b : r else r

-- [( 1 , "a" ), ( 2 , "b" ), ( 3 , "c" ), ( 4 , "d" )]
--   ^.. folded
--     . folding ( \ ( a , b ) -> if ( even a ) then return b else [] )