module Game where

import Prelude

import Effect (Effect)
import Effect.Ref (Ref, new, read)

type World = {
    x :: Number
}

type WorldRef = Ref World

genWorld :: Effect WorldRef
genWorld = new { x: 0.0 }

readWorld :: WorldRef -> Effect World
readWorld = read

updateWorld :: WorldRef -> Effect World
updateWorld stateRef = do
    state <- read stateRef
    pure { x: state.x + 1.0 }

resume :: forall frame. (Effect Unit -> Effect frame) -> WorldRef -> Effect Unit
resume reqFrame world = do
  _ <- updateWorld world
  frame <- reqFrame $ resume reqFrame world
  pure unit