module Chapter7.TraversalActions where

import Control.Lens
import Data.Char ( toUpper , toLower )
import Control.Applicative
import Control.Monad.State

sevenTA1 :: Maybe (String, String)
sevenTA1 = sequenceAOf _1 ( Nothing , "Rosebud" )

-- Nothing

sevenTA2 :: [[(Char, Int)]]
sevenTA2 = sequenceAOf ( traversed . _1 ) [("ab", 1), ("cd", 2)]

-- [ [( 'a' , 1 ) ,( 'c' , 2 )]
-- , [( 'a' , 1 ) ,( 'd' , 2 )]
-- , [( 'b' , 1 ) ,( 'c' , 2 )]
-- , [( 'b' , 1 ) ,( 'd' , 2 )]]

sevenTA3 :: ZipList [Int]
sevenTA3 = sequenceAOf traversed [ ZipList [ 1 , 2 ], ZipList [ 3 , 4 ]]

-- ZipList { getZipList = [[ 1 , 3 ],[ 2 , 4 ]]}

result = traverseOf ( beside traversed both ) ( \ n -> modify ( + n ) >> get ) ([ 1 , 1 , 1 ], ( 1 , 1 ))

blah :: (([Int], (Int, Int)), Int)
blah = runState result 0


-- (([ 1 , 2 , 3 ],( 4 , 5 )), 5 )


-- 2. Rewrite the following using the infix-operator for traverseOf

sevenTA4 :: [(String, Bool)]
sevenTA4 = ( "ab" , True ) & ( _1 . traversed ) %%~ ( \ c -> [ toLower c , toUpper c ])

-- [ ( "ab" , True )
-- , ( "aB" , True )
-- , ( "Ab" , True )
-- , ( "AB" , True ) ]

-- 3. Given the following data definitions, write a validation function which uses traverseOf or %%~ to validates that the given user has an age value above zero and below 150. Return an appropriate error message if it fails validation.

data User = User { _name :: String , _age :: Int } deriving Show

makeLenses ''User

data Account = Account { _id :: String , _user :: User } deriving Show

makeLenses ''Account

validateAge :: Account -> Either String Account
validateAge =
  traverseOf (user . age) validAge

validAge :: Int -> Either String Int
validAge age
  | age <= 0 = Left "Age is too low"
  | age > 150 = Left "Age is too high"
  | otherwise = Right age

values :: Applicative f => ( a -> f b ) -> [ a ] -> f [ b ]
values _ [] = pure []
values handler ( a : as ) = liftA2 ( : ) ( handler a ) ( values handler as )
