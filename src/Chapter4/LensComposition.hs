module Chapter4.LensComposition where

import           Control.Lens.TH                ( makeLenses )
import           Control.Lens.Type              ( Lens )
import           Control.Lens.Lens              ( lens )
import Control.Lens

-- 1. Fill in the blank with the appropriate composition of tuple lenses in the following statement:

lcOne :: String
lcOne = view (_2 . _1 . _2) ( "Ginerva" , (( "Galileo" , "Waldo" ), "Malfoy" ))
-- "Waldo"


-- 2. Given the following lens types, fill in the missing type of mysteryDomino
data Five
data Eight
data Two
data Three

fiveEightDomino :: Lens' Five Eight
fiveEightDomino = undefined

mysteryDomino :: Lens' Eight Two
mysteryDomino = undefined

twoThreeDomino :: Lens' Two Three
twoThreeDomino = undefined

dominoTrain :: Lens' Five Three
dominoTrain = fiveEightDomino . mysteryDomino . twoThreeDomino

-- 3. Rewrite polymorphic lens

data Armadillo
data Hedgehog
data Platypus
data BabySloth

lcThreeLens :: Functor f => ( Armadillo -> f Hedgehog ) -> ( Platypus -> f BabySloth )
lcThreeLens = undefined

lcThreeStabLens :: Lens Platypus BabySloth Armadillo Hedgehog
lcThreeStabLens = lcThreeLens

-- 4. Big lens composition

-- spuzorktrowmble :: Lens Chumble Spuzz Gazork Trowlg
-- gazorlglesnatchka :: Lens Gazork Trowlg Bandersnatch Yakka
-- zinkattumblezz :: Lens Zink Wattoom Chumble Spuzz
-- gruggazinkoom :: Lens Grug Pubbawup Zink Wattoom
-- banderyakoobog :: Lens Bandersnatch Yakka Foob Mog
-- boowockugwup :: Lens Boojum Jabberwock Grug Pubbawup
-- snajubjumwock :: Lens Snark JubJub Boojum Jabberwock
