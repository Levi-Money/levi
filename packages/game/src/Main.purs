module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)

import WebEngine (requestFrame)

processFrame :: Effect Unit
processFrame = log "processFrame"

main :: Effect Unit
main = do 
  frame <- requestFrame processFrame
  pure unit