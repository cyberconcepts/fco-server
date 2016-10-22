{-# LANGUAGE DataKinds, TypeOperators #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE NoImplicitPrelude, OverloadedStrings #-}

module Fco.Server (
    startApp
) where

import BasicPrelude
import Data.Aeson
import GHC.Generics
import Network.Wai
import Network.Wai.Handler.Warp
import Servant


type API = Get '[JSON] [Command]
  :<|> "commands" :> Get '[JSON] [Command]


data Command = Command {
  name :: Text,
  description :: Text,
  url :: Text
} deriving (Eq, Show, Generic)

instance ToJSON Command


startApp :: IO ()
startApp = run 8080 app

app :: Application
app = serve api server

api :: Proxy API
api = Proxy


server :: Server API
server = return commandsRoot
    :<|> return commands


commandsRoot :: [Command]
commandsRoot =
  [Command "commands" "Get a list of available commands" 
           "http://localhost:8080/commands"
  ]

commands :: [Command]
commands =
  [Command "commands" "Get a list of available commands" 
           "http://localhost:8080/commands",
   Command "namespaces" "Get a list of available namespaces" 
           "http://localhost:8080/namespaces",
   Command "triples" "Get info on stored triples/quads" 
           "http://localhost:8080/triples"
  ]
