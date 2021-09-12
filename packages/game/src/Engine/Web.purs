module Engine.Web where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import Graphics.Canvas (CanvasElement, clearRect, getCanvasElementById, getCanvasHeight, getCanvasWidth, getContext2D)

getCanvasElement :: Effect (Maybe CanvasElement)
getCanvasElement = getCanvasElementById "game"

clear :: Effect Unit
clear = getCanvasElement >>= case _ of
    Nothing -> throw "Could not get canvas element"
    Just canvas -> do
        ctx <- getContext2D canvas
        width <- getCanvasWidth canvas
        height <- getCanvasHeight canvas
        clearRect ctx { x: 0.0, y: 0.0, width, height }