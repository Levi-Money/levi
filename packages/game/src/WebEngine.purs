module WebEngine where

import Prelude
import Effect (Effect)
import Web.HTML (window)
import Web.HTML.Window (RequestAnimationFrameId, requestAnimationFrame)

requestFrame :: Effect Unit -> Effect RequestAnimationFrameId
requestFrame processFrame = do
    w <- window
    frame <- requestAnimationFrame processFrame w
    pure frame