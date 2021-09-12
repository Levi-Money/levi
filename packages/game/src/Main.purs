module Main where

import Prelude
import Effect (Effect)
import Game (resume)
import Partial.Unsafe (unsafePartial)

main :: Effect Unit
main = unsafePartial do
  resume