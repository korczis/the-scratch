module Component.SignUp.View exposing (view)

import Html exposing (..)
import Msg

import Component.SignIn.View

view : Html Msg.Msg
view =
    Component.SignIn.View.view
