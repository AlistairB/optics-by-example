module Chapter3.LensVirtualFields where

import           Control.Lens.TH                ( makeLenses )

data User = User
  { _firstName :: String
  , _lastName :: String
  , _username :: String
  , _email :: String
  }

makeLenses ''User
