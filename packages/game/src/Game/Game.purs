module Game where

import Prelude
import Effect (Effect)
import Effect.Console (log)
import Signal (Signal, runSignal, foldp, sampleOn, map2)
import Signal.DOM (keyPressed)
import Signal.Time (second, every)
import Engine.Web (clear)

type State = Int

update :: Int -> State -> State
update dir state = state + dir

render :: State -> Effect Unit
render state = do
    log $ "rendering state: " <> (show state)
    clear

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
inputSignal = sampleOn (every second) <$> inputDirSignal

resume :: Effect Unit
resume = do
    dirSignal <- inputSignal
    let game = foldp update 0 dirSignal
    runSignal (map render game)