module Main where

import Prelude

import Effect (Effect)
import Engine.Web (requestFrame, log)
import Game (processFrame)

main :: Effect Unit
main = do 
  frame <- requestFrame $ processFrame $ log
  pure unit