module Game where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Signal (Signal, runSignal, foldp, sampleOn, map2)
import Signal.DOM (keyPressed)
import Signal.Time (Time, every, second)
import Engine.Web as Engine
import Game.Wallet as Wallet

notFoundCanvas :: String
notFoundCanvas = "Could not get canvas element" 

type State = {
    engine :: Engine.State,
    wallet :: Wallet.State
}

initState :: Effect State
initState = do
    engine <- Engine.initState
    wallet <- Wallet.initState
    pure { engine, wallet }

update :: Number -> State -> State
update dirSignal state = {
    engine: state.engine,
    wallet: Wallet.update dirSignal state.wallet
}
 
render :: State -> Effect Unit
render state = do
    log $ "rendering"
    Engine.clear state.engine
    Wallet.render state.wallet state.engine

fps :: Time -> Signal Time
fps x = every (second/x)

inputDirSignal :: Effect (Signal Number)
inputDirSignal = 
    let 
        f = \l r -> if l 
                    then -1.0
                    else if r
                         then 1.0
                         else 0.0
    in
      map2 f <$> (keyPressed 37) <*> (keyPressed 39)

inputSignal :: Effect (Signal Number)
inputSignal = sampleOn (fps 30.0) <$> inputDirSignal

resume :: Effect Unit
resume = do
    state <- initState
    dirSignal <- inputSignal
    let game = foldp update state dirSignal
    runSignal (map render game)