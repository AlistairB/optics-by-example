module Chapter7.SimpleTraversals where

import Control.Lens
import Data.Char ( toUpper )

-- 1.

-- What type of optic do you get when you compose a traversal with a fold?

-- fold

-- Which of the optics we’ve learned can act as a traversal?

-- lens, traversal

-- Which of the optics we’ve learned can act as a fold?

-- fold, lens, traversal

-- 2.

sevenST1 :: (String, String)
sevenST1 = ( "Jurassic" , "Park" ) & both .~ "N/A"

-- ( "N/A" , "N/A" )

sevenST2 :: (String, String)
sevenST2 = ( "Jurassic" , "Park" ) & both . traversed .~ 'x'

-- ( "xxxxxxxx" , "xxxx" )

sevenST3 :: (String, [String])
sevenST3 = ( "Malcolm" , [ "Kaylee" , "Inara" , "Jayne" ]) & beside id traversed %~ take 3

-- ( "Mal" , [ "Kay" , "Ina" , "Jay" ])

sevenST4 :: (String, [String])
sevenST4 = ( "Malcolm" , [ "Kaylee" , "Inara" , "Jayne" ]) & _2 . element 1 .~ "River"

-- ( "Malcolm" , [ "Kaylee" , "River" , "Jayne" ])

sevenST5 :: [String]
sevenST5 = [ "Die Another Day" , "Live and Let Die" , "You Only Live Twice" ] & traversed . elementOf worded 1 . traversed .~ 'x'

-- [ "Die xxxxxxx Day" , "Live xxx Let Die" , "You xxxx Live Twice" ]

sevenST6 :: ((Int, Int), (Int, Int))
sevenST6 = (( 1 , 2 ), ( 3 , 4 )) & beside both both +~ 1

-- (( 2 , 3 ), ( 4 , 5 ))

sevenST7 :: (Int, (Int, [Int]))
sevenST7 = ( 1 , ( 2 , [ 3 , 4 ])) & beside id (beside id traversed) +~ 1

-- ( 2 , ( 3 , [ 4 , 5 ]))

sevenST8 :: ((Bool, String), (Bool, String), (Bool, String))
sevenST8 = (( True , "Strawberries" ), ( False , "Blueberries" ), ( True , "Blackberries" ))
  & each . filtered fst . _2 . taking 5 traversed  %~ toUpper

-- (( True , "STRAWberries" ), ( False , "Blueberries" ), ( True , "BLACKberries" ))

sevenST9 :: (String, String, String)
sevenST9 =
  (( True , "Strawberries" ), ( False , "Blueberries" ), ( True , "Blackberries" ))
    & each %~ snd

-- ( "Strawberries" , "Blueberries" , "Blackberries" )
