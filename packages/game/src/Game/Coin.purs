module Game.Coin where

import Prelude

import Effect (Effect)
import Record (merge)
import Data.Array (last)
import Data.Int (toNumber)
import Data.Maybe (Maybe(..))
import Engine.Web as E
import Game.Input (Touch) as I
import Math (pi)

type State = {
      x :: Number
    , y :: Number
    , enabled :: Boolean
}

initState :: Effect State
initState = pure {
      x: 50.0
    , y: 50.0
    , enabled: false
}

update :: Array I.Touch -> State -> State
update touchs state
  | state.enabled = case last touchs of
    Just touch -> merge {
          x: toNumber touch.clientX
        , y: toNumber touch.clientY
    } state
    Nothing -> state
  | otherwise = state

render :: State -> E.State -> Effect Unit
render {x, y, enabled } engineState
  | enabled = do
    E.setColor engineState "#FFCF00"
    E.drawArc engineState {
          x
        , y
        , start: 0.0
        , end: 2.0 * pi
        , radius: 30.0
    }
  | otherwise = pure unit