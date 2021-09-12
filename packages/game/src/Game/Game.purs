module Game where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Engine.Web (clear)
import Signal (Signal, runSignal, foldp, sampleOn, map2)
import Signal.DOM (keyPressed)
import Signal.Time (Time, every, second)

type State = Int

update :: Int -> State -> State
update dir state = state + dir

render :: State -> Effect Unit
render state = do
    log $ "rendering state: " <> (show state)
    clear

fps :: Time -> Signal Time
fps x = every (second/x)

inputDirSignal :: Effect (Signal Int)
inputDirSignal = 
    let 
        f = \l r -> if l 
                    then -1 
                    else if r
                         then 1
                         else 0
    in
      map2 f <$> (keyPressed 37) <*> (keyPressed 39)

inputSignal :: Effect (Signal Int)
inputSignal = sampleOn (fps 20.0) <$> inputDirSignal

resume :: Effect Unit
resume = do
    dirSignal <- inputSignal
    let game = foldp update 0 dirSignal
    runSignal (map render game)