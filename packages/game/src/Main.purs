module Main where

import Prelude

import Effect (Effect)
import Engine.Console (log)
import Engine.Web (requestFrame)
import Game (genWorld, resume, readWorld)

main :: Effect Unit
main = do 
  world <- genWorld
  log "World started"
  _ <- resume requestFrame world
  worldState <- readWorld world
  log $ "World updated: " <> show worldState