module Data.Session exposing (Session)

import Phoenix.Socket

import Component.Application.Msg exposing(Msg)
import Data.User as User exposing (User)


type alias Session =
    { user : Maybe User
    , socket: Maybe (Phoenix.Socket.Socket Msg)
    }

