module Game.Coin where

import Prelude

import Effect (Effect)
import Data.Array (last)
import Data.Int (toNumber)
import Data.Maybe (Maybe(..))
import Engine.Web as E
import Game.Input (Touch) as I
import Math (pi)

type State = {
      x :: Number
    , y :: Number
}

initState :: Effect State
initState = pure {
      x: 50.0
    , y: 50.0
}

update :: Array I.Touch -> State -> State
update touchs state = case last touchs  of
    Just touch -> {
          x: toNumber touch.clientX
        , y: toNumber touch.clientY
    }
    Nothing -> state

render :: State -> E.State -> Effect Unit
render state engineState = do
    E.setColor engineState "#FFCF00"
    E.drawArc engineState {
          x: state.x
        , y: state.y
        , start: 0.0
        , end: 2.0 * pi
        , radius: 30.0
    }