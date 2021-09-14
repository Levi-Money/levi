module Game where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Signal (foldp, runSignal) as S
import Engine.Web (State, initState, clear) as E
import Game.Input (Touch, State, initState, touch) as I
import Game.Coin (State, initState, update, render) as Coin

type State = {
    input :: I.State,
    engine :: E.State,
    coin :: Coin.State
}

initState :: Effect State
initState = do
    engine <- E.initState
    input <- I.initState
    coin <- Coin.initState
    pure { engine, input, coin }

update :: Array I.Touch -> State -> State
update touchs state = {
    engine: state.engine,
    input: { touchs },
    coin: Coin.update touchs state.coin
}
 
render :: State -> Effect Unit
render state = do
    log $ "rendering"
    E.clear state.engine
    Coin.render state.coin state.engine

resume :: Effect Unit
resume = do
    state <- initState
    touchSignal <- I.touch
    let game = S.foldp update state touchSignal
    S.runSignal (map render game)