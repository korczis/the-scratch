module Component.Application.View exposing(view)

-- Global Imports
import Html exposing(..)

-- Local Imports
import Component.Application.Model exposing(Model)
import Component.Home.View
import Component.Map.View
import Component.Navbar.View
import Component.NotFound.View
import Component.Page.Component
import Component.SignIn.View
import Component.SignUp.View

import Msg

viewPage : Model -> Html Msg.Msg
viewPage model =
    let
        page = model.page
    in
        case page of
            Component.Page.Component.Loaded Component.Page.Component.Blank ->
                div [] [ text "Blank" ]

            Component.Page.Component.Loaded Component.Page.Component.Home ->
                Component.Home.View.view model.carousel

            Component.Page.Component.Loaded Component.Page.Component.Map ->
                Component.Map.View.view model.map model.window.size

            Component.Page.Component.Loaded Component.Page.Component.NotFound ->
                Component.NotFound.View.view

            Component.Page.Component.Loaded Component.Page.Component.SignIn ->
                Component.SignIn.View.view

            Component.Page.Component.Loaded Component.Page.Component.SignUp ->
                Component.SignUp.View.view

            Component.Page.Component.TransitioningFrom _ ->
                div [] []

view : Model -> Html Msg.Msg
view model =
    div []
        [ Component.Navbar.View.view model -- Interactive and responsive menu
        , viewPage model

        -- , mainContent model
        ]
