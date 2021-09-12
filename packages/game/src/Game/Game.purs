module Game where

import Prelude
import Effect (Effect)

processFrame :: (String -> Effect Unit) -> Effect Unit
processFrame log = log "processFrame"