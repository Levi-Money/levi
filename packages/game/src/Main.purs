module Main where

import Prelude

import Effect (Effect)
import Engine.Console (log)
import Engine.Web (requestFrame)
import Game (genWorld, readWorld, resume)

main :: Effect Unit
main = do 
  world <- genWorld
  readWorld world >>= (\w -> log $ "World changed: " <> show w)
  resume requestFrame world