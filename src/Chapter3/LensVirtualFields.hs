module Chapter3.LensVirtualFields where

import           Control.Lens.TH                ( makeLenses )
import           Control.Lens.Type              ( Lens' )
import           Control.Lens.Lens              ( lens )
import           Data.List                      ( intercalate )

data User = User
  { _firstName :: String
  , _lastName :: String
  , _email :: String
  }

makeLenses ''User

username :: Lens' User String
username = lens getter setter
 where
  getter (User fn sn _) = fn <> " " <> sn
  setter (User _ _ email) fullName =
    let nameWords = words fullName
        firstName = head nameWords
        lastName  = unwords (tail nameWords)
    in  User firstName lastName email
