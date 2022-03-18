module Engine.Web where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Int (toNumber)
import Effect (Effect)
import Effect.Exception (throw)
import Graphics.Canvas as C

type Context = C.Context2D
type Point = {
      x :: Int
    , y :: Int
}
type Arc = {
      position :: Point
    , start :: Number
    , end :: Number
    , radius :: Number
}
type StateCanvas = {
      element :: C.CanvasElement
    , context :: Context
    , width :: Number
    , height :: Number
}
type State = {
    canvas :: StateCanvas
}

makePoint :: Int -> Int -> Point
makePoint x y = { x, y }

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
      x: 0.0
    , y: 0.0
    , width
    , height
}

setColor :: State -> String -> Effect Unit
setColor {canvas: { context }} color = do
    C.setFillStyle context color
    C.setStrokeStyle context color

toCanvasArc :: Arc -> C.Arc
toCanvasArc { position, start, end, radius } = {
      x: toNumber position.x
    , y: toNumber position.y
    , start
    , end
    , radius
}

drawArc :: State -> Arc -> Effect Unit
drawArc {canvas: { context }} arc = do
    C.beginPath context
    C.arc context $ toCanvasArc arc
    C.stroke context
    C.fill context