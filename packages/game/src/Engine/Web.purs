module Engine.Web where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Console (log)
import Effect.Exception (throw)
import Graphics.Canvas as C

type Context = C.Context2D
type Dimensions = C.Dimensions
type Rectangle = C.Rectangle
type Arc = C.Arc
type StateCanvas = {
    element :: C.CanvasElement ,
    context :: Context ,
    width :: Number,
    height :: Number
}
type State = {
    canvas :: StateCanvas
}

getCanvasElement :: Effect (Maybe C.CanvasElement)
getCanvasElement = C.getCanvasElementById "game"

initState :: Effect State
initState = getCanvasElement >>= case _ of
    Nothing -> throw "Could not get canvas element"
    Just element -> do
        context <- C.getContext2D element
        width <- C.getCanvasWidth element
        height <- C.getCanvasHeight element
        pure { canvas: { element, context, width, height } }
    
clear :: State -> Effect Unit
clear {canvas: {context, width, height}} = C.clearRect context {
    x: 0.0,
    y: 0.0,
    width,
    height
}

drawArc :: State -> Arc -> Effect Unit
drawArc {canvas: { context }} arc = do
    C.arc context arc
    C.setFillStyle context "#000000"
    C.setStrokeStyle context "#000000"
    -- log $  "Drawing arc: " <> show arc.x