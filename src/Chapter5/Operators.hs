module Chapter5.Operators where

import           Control.Lens.TH                ( makeLenses )
import           Control.Lens.Type              ( Lens )
import           Control.Lens.Lens              ( lens )
import           Control.Lens
import Control.Lens.Operators
import Control.Lens.Setter
import Data.Char ( toUpper )


data Gate = Gate
  { _open :: Bool
  , _oilTemp :: Float
  } deriving Show

makeLenses ''Gate

data Army = Army
  { _archers :: Int
  , _knights :: Int
  } deriving Show

makeLenses ''Army

data Kingdom = Kingdom
  { _name :: String
  , _army :: Army
  , _gate :: Gate
  } deriving Show

makeLenses ''Kingdom

duloc :: Kingdom
duloc = Kingdom { _name = "Duloc"
                , _army = Army { _archers = 22, _knights = 14 }
                , _gate = Gate { _open = True, _oilTemp = 10.0 }
                }


goalA :: Kingdom
goalA =
  duloc & name <>~ ": a perfect place"
        & army . knights +~ 28
        & gate . open &&~ False

-- goalA = Kingdom { _name = "Duloc: a perfect place"
--                 , _army = Army { _archers = 22, _knights = 42 }
--                 , _gate = Gate { _open = False, _oilTemp = 10.0 }
--                 }

goalB :: Kingdom
goalB =
  duloc & name <>~ "instein"
        & army . archers -~ 5
        & army . knights -~ 22
        & gate . open &&~ False
        & gate . oilTemp *~ 10

-- goalB = Kingdom { _name = "Dulocinstein"
--                 , _army = Army { _archers = 17, _knights = 26 }
--                 , _gate = Gate { _open = True, _oilTemp = 100.0 }
--                 }

goalC :: (String, Kingdom)
goalC =
  duloc & name <>~ ": Home"
        & army . knights -~ 28
        & gate . oilTemp //~ 2
        & name <<<>~ " of the talking Donkeys"



-- goalC =
--   ( "Duloc: Home"
--   , Kingdom { _name = "Duloc: Home of the talking Donkeys"
--             , _army = Army { _archers = 22, _knights = 14 }
--             , _gate = Gate { _open = True, _oilTemp = 5.0 }
--             }
--   )


-- 2.

fiveOp :: (Bool, String)
fiveOp = ( False , "opossums" ) & _1 ||~ True -- ( True , "opossums" )

fiveOp2 :: Int
fiveOp2 = 2 & id *~ 3 --6

fiveOp3 :: ((Bool, String), Double)
fiveOp3 =
  (( True , "Dudley" ), 55.0 )
    & _1 . _2 <>~ " - the worst"
    & _2 -~ 15
    & _2 //~ 2
    & _1 . _2 %~ map toUpper
    & _1 . _1 ||~ False

-- (( False , "DUDLEY - THE WORST" ), 20.0 )

-- type signature of %~
(%%%~) :: Lens s t a b -> (a -> b) -> s -> t
(%%%~) = (%~)
