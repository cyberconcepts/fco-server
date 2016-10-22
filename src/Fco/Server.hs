{-# LANGUAGE DataKinds, TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}

module Fco.Server (
    startApp
) where

import Data.Aeson
import GHC.Generics
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

type API = Get '[JSON] [Command]

data Command = Command {
  name :: String,
  description :: String,
  url :: String
} deriving (Eq, Show, Generic)

instance ToJSON Command

startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy

server :: Server API
server = return commands

commands :: [Command]
commands =
  [Command "commands" "Get a list of available commands" "http://localhost:8080/commands"
  ]
