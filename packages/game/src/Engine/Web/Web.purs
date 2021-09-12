module Engine.Web where

import Prelude

import Effect (Effect)
import Web.HTML (Window, window)
import Web.HTML.Window (RequestAnimationFrameId, requestAnimationFrame)

type RequestFrameId = RequestAnimationFrameId

requestFrame :: Effect Unit -> Effect RequestFrameId
requestFrame processFrame = do
    w <- window
    frame <- req processFrame w
    pure frame
    where
        req :: Effect Unit -> Window -> Effect RequestFrameId
        req = requestAnimationFrame