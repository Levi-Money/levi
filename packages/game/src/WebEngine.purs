module WebEngine where

import Prelude
import Effect (Effect)
import Web.HTML.Window (Window, RequestAnimationFrameId, requestAnimationFrame)

requestFrame :: Effect Unit -> Window -> Effect RequestAnimationFrameId
requestFrame = requestAnimationFrame