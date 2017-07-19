module Component.Application.View exposing(view)

-- Global Imports
import Html exposing(..)

-- Local Imports
import Component.Application.Model exposing(Model)
import Component.Application.Msg as Msg
import Component.Home.View
import Component.Map.View
import Component.Navbar.View
import Component.NotFound.View
import Component.Page.Component as Page
import Component.SignIn.View
import Component.SignUp.View


viewPage : Model -> Html Msg.Msg
viewPage model =
    let
        page = model.page
    in
        case page of
            Page.Loaded Page.Blank ->
                div [] [ text "Blank" ]

            Page.Loaded Page.Home ->
                Component.Home.View.view model.carousel

            Page.Loaded Page.Map ->
                Component.Map.View.view model.map model.window.size

            Page.Loaded Page.NotFound ->
                Component.NotFound.View.view

            Page.Loaded Page.SignIn ->
                Component.SignIn.View.view

            Page.Loaded Page.SignUp ->
                Component.SignUp.View.view

            Page.TransitioningFrom _ ->
                div [] []

view : Model -> Html Msg.Msg
view model =
    div []
        [ Component.Navbar.View.view model -- Interactive and responsive menu
        , viewPage model

        -- , mainContent model
        ]
