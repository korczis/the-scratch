module Data.Session exposing (Session, attempt)

import Phoenix.Socket
import Phoenix.Channel
import Phoenix.Push

import Data.AuthToken exposing (AuthToken)
import Data.User as User exposing (User)
import Util exposing ((=>))
import Msg

type alias Session =
    { user : Maybe User
    , socket: Phoenix.Socket.Socket Msg.Msg
    }


attempt : String -> (AuthToken -> Cmd msg) -> Session -> ( List String, Cmd msg )
attempt attemptedAction toCmd session =
    case Maybe.map .token session.user of
        Nothing ->
            [ "You have been signed out. Please sign back in to " ++ attemptedAction ++ "." ] => Cmd.none

        Just token ->
            [] => toCmd token
