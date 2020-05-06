module Chapter7.TraversalActions where

import Control.Lens
import Data.Char ( toUpper )

sevenTA1 :: Maybe (String, String)
sevenTA1 = sequenceAOf _1 ( Nothing , "Rosebud" )

-- Nothing

sevenTA2 :: [[(Char, Int)]]
sevenTA2 = sequenceAOf ( traversed . _1 ) [("ab", 1), ("cd", 2)]

-- [ [( 'a' , 1 ) ,( 'c' , 2 )]
-- , [( 'a' , 1 ) ,( 'd' , 2 )]
-- , [( 'b' , 1 ) ,( 'c' , 2 )]
-- , [( 'b' , 1 ) ,( 'd' , 2 )]]

sevenTA3 :: ZipList Int
sevenTA3 = sequenceAOf _ [ ZipList [ 1 , 2 ], ZipList [ 3 , 4 ]]

-- ZipList { getZipList = [[ 1 , 3 ],[ 2 , 4 ]]}
