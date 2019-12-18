module Chapter3.SelfCorrectingLenses where

import           Control.Lens.TH                ( makeLenses )
import           Control.Lens.Type              ( Lens' )
import           Control.Lens.Lens              ( lens )
import           Data.List                      ( intercalate )

data ProducePrices = ProducePrices
  { _limePrice :: Float
  , _lemonPrice :: Float
  } deriving Show

limeCost :: Lens' ProducePrices Float
limeCost = lens getter setter
  where
    getter = undefined
    setter = undefined

lemonCost :: Lens' ProducePrices Float
lemonCost = lens getter setter
  where
    getter = undefined
    setter = undefined
