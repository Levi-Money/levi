module Engine.Console where

import Prelude

import Effect (Effect)
import Effect.Console (log) as Effect.Console

log :: String -> Effect Unit
log = Effect.Console.log
