module Game.Input where

import Prelude

import Effect (Effect)
import Signal (Signal) as S
import Signal.DOM (Touch, touch) as S.DOM

type Touch = S.DOM.Touch
type Signal = S.Signal
type State = {
    touchs :: Array Touch
}

initState :: Effect State
initState = pure { touchs: [] }

touch :: Effect ( Signal (Array Touch) )
touch = S.DOM.touch