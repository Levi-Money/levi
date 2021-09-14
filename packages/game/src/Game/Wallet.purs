module Game.Wallet where

import Prelude

import Effect (Effect)
import Engine.Web as Engine
import Math (pi)

type State = Number

initState :: Effect Number
initState = pure 0.0

update :: Number -> State -> State
update dirSignal state = state + dirSignal 

render :: State -> Engine.State -> Effect Unit
render state engineState = Engine.drawArc engineState {
    x: 50.0 + state,
    y: 100.0,
    start: 0.0,
    end: 2.0 * pi,
    radius: 50.0
}