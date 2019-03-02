module Types where

import RIO
import RIO.Process
import qualified RIO.Text as T

-- | Command line arguments
data Options = Options
  { optionsVerbose :: Bool
  , contest :: String
  , username :: Maybe ByteString
  , password :: Maybe ByteString
  }

data App = App
  { appLogFunc :: !LogFunc
  , appProcessContext :: !ProcessContext
  , appOptions :: !Options
  -- Add other app-specific configuration information here
  }

instance HasLogFunc App where
  logFuncL = lens appLogFunc (\x y -> x { appLogFunc = y })
instance HasProcessContext App where
  processContextL = lens appProcessContext (\x y -> x { appProcessContext = y })
