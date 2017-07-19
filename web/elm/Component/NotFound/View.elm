module Component.NotFound.View exposing(..)

-- Core Imports
import Html exposing (..)

-- Local Imports
import Component.Application.Msg as Msg

view : Html Msg.Msg
view =
    div [] [ text "Not Found!" ]
