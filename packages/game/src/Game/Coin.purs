module Game.Coin where

import Prelude

import Effect (Effect)
import Data.Array (last)
import Data.Int (toNumber)
import Data.Maybe (Maybe(..))
import Engine.Web as E
import Game.Input (Touch) as I
import Math (pi)

type State = Number

initState :: Effect Number
initState = pure 0.0

update :: Array I.Touch -> State -> State
update touchs state = case last touchs  of
    Just touch -> toNumber touch.clientX
    Nothing -> state

render :: State -> E.State -> Effect Unit
render state engineState = do
    E.setColor engineState "#FFCF00"
    E.drawArc engineState {
        x: 50.0 + state,
        y: 100.0,
        start: 0.0,
        end: 2.0 * pi,
        radius: 50.0
    }