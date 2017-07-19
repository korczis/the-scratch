module Data.Session exposing (Session)

import Phoenix.Socket

import Data.User as User exposing (User)
import Msg

type alias Session =
    { user : Maybe User
    , socket: Phoenix.Socket.Socket Msg.Msg
    }

