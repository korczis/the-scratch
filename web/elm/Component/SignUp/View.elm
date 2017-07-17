module Component.SignUp.View exposing (Model, view)

import Html exposing (..)
import Msg

import Component.SignIn.View

type alias Model =
    {}


view : Html Msg.Msg
view =
    Component.SignIn.View.view
