module Chapter6.FoldFiltering where

import Control.Lens

data Card =
    Card { _name    :: String
         , _aura    :: Aura
         , _holo    :: Bool -- Is the card holographic
         , _moves   :: [Move]
         } deriving (Show, Eq)

data Move =
    Move { _moveName  :: String
         , _movePower :: Int
         } deriving (Show, Eq)

-- Each card has an aura-type
data Aura
    = Wet
    | Hot
    | Spark
    | Leafy
    deriving (Show, Eq)

makeLenses ''Card
makeLenses ''Move

deck = [ Card "Skwortul"    Wet False   [Move "Squirt" 20]
       , Card "Scorchander" Hot False   [Move "Scorch" 20]
       , Card "Seedasaur"   Leafy False [Move "Allergize" 20]
       , Card "Kapichu"     Spark False [Move "Poke" 10 , Move "Zap" 30]
       , Card "Elecdude"    Spark False [Move "Asplode" 50]
       , Card "Garydose"    Wet True    [Move "Gary's move" 40]
       , Card "Moisteon"    Wet False   [Move "Soggy" 3]
       , Card "Grasseon"    Leafy False [Move "Leaf Cut" 30]
       , Card "Spicyeon"    Hot False   [Move "Capsaicisize" 40]
       , Card "Sparkeon"    Spark True  [Move "Shock" 40 , Move "Battery" 50]
       ]

-- List all the cards whose name starts with 'S' .

ff1 :: [Card]
ff1 = deck ^.. folded . filteredBy (name . _head . only 'S')

-- What’s the lowest attack power of all moves?

ff2 :: Maybe Int
ff2 = minimumOf (folded . moves . folded . movePower) deck

-- What’s the name of the first card which has more than one move?

ff3 :: Maybe String
ff3 = deck ^? folded . filtered ((>1) . length . _moves) . name

-- Are there any Hot cards with a move with more than 30 attack power?

ff4 :: Bool
ff4 =
  anyOf
    ( folded
    . filteredBy (aura . only Hot)
    . moves
    . folded
    . movePower)
    (>30)
    deck

-- List the names of all holographic cards with a Wet aura.

ff5 :: [String]
ff5 = deck ^.. (folded . filteredBy (aura . only Wet) . name)

-- What’s the sum of all attack power for all moves belonging to non-Leafy cards?

ff6 :: Int
ff6 = sumOf
  (folded . filtered ((/=) Leafy . _aura) . moves . folded . movePower)
  deck
