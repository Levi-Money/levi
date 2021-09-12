module Engine.Web where

import Prelude

import Effect (Effect)
import Effect.Console (log) as Effect.Console
import Web.HTML (Window, window)
import Web.HTML.Window (RequestAnimationFrameId, requestAnimationFrame)

type RequestFrameId = RequestAnimationFrameId

log :: String -> Effect Unit
log = Effect.Console.log

requestFrame :: Effect Unit -> Effect RequestFrameId
requestFrame processFrame = do
    w <- window
    frame <- req processFrame w
    pure frame
    where
        req :: Effect Unit -> Window -> Effect RequestFrameId
        req = requestAnimationFrame