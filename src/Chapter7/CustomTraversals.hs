module Chapter7.CustomTraversals where

import Control.Lens
import Data.Char ( toUpper , toLower )
import Control.Applicative
import Control.Monad.State

data Transaction =
    Withdrawal { _amount :: Int }
  | Deposit { _amount :: Int }
  deriving Show

makeLenses ''Transaction

-- amountT :: Applicative f => ( Int -> f Int ) -> Transaction -> f Transaction
amountT :: Traversal' Transaction Int
amountT handler (Withdrawal a) = handler a <&> Withdrawal
amountT handler (Deposit a) = handler a <&> Deposit

values :: Applicative f => ( a -> f b ) -> [ a ] -> f [ b ]
values _ [] = pure []
values handler ( a : as ) = liftA2 ( : ) ( handler a ) ( values handler as )

-- both :: Applicative f => ( a -> f b ) -> (a, a) -> f (b, b)
both :: Traversal ( a , a ) ( b , b ) a b
both h (a, a')  = liftA2 (,) (h a) (h a')

-- transactionDelta :: Applicative f => (Int -> f Int) -> Transaction -> Transaction
transactionDelta :: Traversal' Transaction Int
transactionDelta handler (Withdrawal a) = (negate <$> handler (negate a)) <&> Withdrawal
transactionDelta handler (Deposit a) = handler a <&> Deposit

-- left :: Applicative f => (Int -> f Int) -> ( Either a b ) -> Transaction
left :: Traversal ( Either a b ) ( Either a' b ) a a'
left handler (Left a) = undefined
