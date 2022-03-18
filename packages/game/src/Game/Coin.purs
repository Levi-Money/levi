module Game.Coin where

import Prelude

import Effect (Effect)
import Record (merge)
import Data.Array (last)
import Data.Maybe (Maybe(..))
import Math (pi)
import Engine.Web as E
import Game.Input (Touch) as I

type State = {
      position :: E.Point
    , enabled :: Boolean
}

initState :: Effect State
initState = pure {
      position: E.makePoint 0 0
    , enabled: false
}

update :: Array I.Touch -> State -> State
update touchs state
  | state.enabled = case last touchs of
    Just { clientX, clientY } -> merge {
        position: E.makePoint clientX clientY
    } state
    Nothing -> state
  | otherwise = state

render :: State -> E.State -> Effect Unit
render { position, enabled } engineState
  | enabled = do
    E.setColor engineState "#FFCF00"
    E.drawArc engineState {
          position
        , start: 0.0
        , end: 2.0 * pi
        , radius: 30.0
    }
  | otherwise = pure unit