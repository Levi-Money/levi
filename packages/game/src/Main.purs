module Main where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Web.HTML (window) as HTML

import WebEngine (requestFrame)

processFrame :: Effect Unit
processFrame = log "processFrame"

main :: Effect Unit
main = do 
  window <- HTML.window
  frame <- requestFrame processFrame window
  pure unit