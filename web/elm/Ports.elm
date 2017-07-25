port module Ports exposing (onSessionChange, storeSession, toJs)

import Json.Encode exposing (Value)

port storeSession : Maybe String -> Cmd msg

port onSessionChange : (Value -> msg) -> Sub msg

port toJs : String -> Cmd msg