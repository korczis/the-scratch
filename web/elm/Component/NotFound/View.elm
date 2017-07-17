module Component.NotFound.View exposing(..)

import Html exposing (..)
import Msg

view : Html Msg.Msg
view =
    div [] [ text "Not Found!" ]
