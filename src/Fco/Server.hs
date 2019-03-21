{-# LANGUAGE NoImplicitPrelude, OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Fco.Server (startApp) where

import BasicPrelude
import Data.Aeson (ToJSON)
import GHC.Generics
import Web.Scotty (get, html, json, param, scotty)

-- |
-- Copyright   :  (C) 2019 team@functionalconcepts.org
-- License     :  MIT
-- Maintainer  :  Helmut Merz <helmutm@cy55.de>
-- Stability   :  experimental
--
-- A REST+JSON server for the functionalconcepts.org project
--


startApp :: IO ()
startApp = scotty 8080 $ do
    get "/" $ json commandsRoot
    get "/commands" $ json commands


-- * example: provide a list of available commands

data Command = Command {
  name :: Text,
  description :: Text,
  url :: Text
} deriving (Eq, Show, Generic)

instance ToJSON Command


commandsRoot :: [Command]
commandsRoot = [head commands]

commands :: [Command]
commands =
  [Command "commands" "Get a list of available commands" 
           "http://localhost:8080/commands",
   Command "namespaces" "Get a list of available namespaces" 
           "http://localhost:8080/namespaces",
   Command "triples" "Get info on stored triples/quads" 
           "http://localhost:8080/triples"
  ]
