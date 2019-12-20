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
    getter = _limePrice
    setter produce limePrice = if   limePrice < 0
                               then produce { _limePrice = 0 }
                               else produce { _limePrice = limePrice }


lemonCost :: Lens' ProducePrices Float
lemonCost = lens getter setter
  where
    getter = _lemonPrice
    setter produce lemonPrice = if   lemonPrice < 0
                              then produce { _lemonPrice = 0 }
                              else produce { _lemonPrice = lemonPrice }
