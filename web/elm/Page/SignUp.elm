module Page.SignUp exposing (Model, view)

import Html exposing (..)
import Msg

import Page.SignIn

type alias Model =
    {}


view : Html Msg.Msg
view =
    Page.SignIn.view
