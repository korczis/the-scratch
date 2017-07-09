module Page.NotFound exposing (Model, view)

import Html exposing (..)
import Msg


type alias Model =
    {}


view : Html Msg.Msg
view =
    div [] [ text "Not Found!" ]
