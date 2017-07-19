module Component.SignUp.View exposing (view)

-- Core Imports
import Html exposing (..)

-- Library Imports
import Component.Application.Msg as Msg
import Component.SignIn.View

view : Html Msg.Msg
view =
    Component.SignIn.View.view
