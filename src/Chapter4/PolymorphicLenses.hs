module Chapter4.PolymorphicLenses where

import           Control.Lens.TH                ( makeLenses )
import           Control.Lens.Type              ( Lens )
import           Control.Lens.Lens              ( lens )

-- 1. Write the type signature of the polymorphic lens which would allow changing a Vorpal x to a Vorpal y .

newtype Vorpal a = Vorpal a

vorpalLens :: Lens (Vorpal a) (Vorpal b) a b
vorpalLens = undefined

-- 2. Find one possible way to write a polymorphic lens which changes the type of the best and worst fields in the Preferences type above. You’re allowed to change the type of the lenses or alter the type itself!

data Preferences a b = Preferences
  { _best :: a
  , _worst :: b
  } deriving ( Show )

preferencesLens :: Lens (Preferences a b) (Preferences c d) (a, b) (c, d)
preferencesLens = lens getter setter
  where
    getter (Preferences a b) = (a, b)
    setter _ (c, d) = Preferences c d

-- 3. We can change type of more complex types too. What is the type of a lens which could change the type variable here:

data Result e = Result
  { _lineNumber :: Int
  , _result :: Either e String
  }

resultLens :: Lens (Result e) (Result e') (Either e String) (Either e' String)
resultLens = undefined

-- 4. It’s thinking time! Is it possible to change more than one type variable at a time using a polymorphic lens?

-- As per my 2 example. Yes? The question is, is it law abiding. I think it is.

-- Answers notes the example of a Sum type with two polymorphic sides as well. Perhaps this is more of a normal case.

-- 5. BONUS Come up with some sort of lens to change from a Predicate a to a Predicate b

newtype Predicate a = Predicate ( a -> Bool )

predicateLens :: Lens (Predicate a) (Predicate a') (a -> Bool) (a' -> Bool)
predicateLens = lens getter setter
  where
    getter (Predicate f) = f
    setter _ f' = Predicate f'
