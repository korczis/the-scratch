module Component.Navbar.View exposing (..)

-- Core Imports
import Html.Attributes exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)
import Http
import HttpBuilder exposing (RequestBuilder, withExpect, withQueryParams)

-- Library Imports
import Bootstrap.Button as Button
import Bootstrap.Form.Input as Input
import Bootstrap.Navbar as Navbar
import Json.Decode as Decode
import Navigation
import Route

-- Local Imports
import Assets
import Component.Application.Model exposing(Model)
import Component.Application.Msg as Msg
import Component.Stats.View

view : Model -> Html Msg.Msg
view model =
    let
        signout = case model.session.user of
            Just user ->
                [ Navbar.formItem [ action "/auth/signout", method "post" ]
                    [ div [ style[ ("padding-right", "10px") ] ] [ text user.email ]
                    , Button.button [ Button.attrs [ onClick Msg.SignOut, href "javascript:void(0);" ] ] [ text "Sign out" ]
                    , input [ Html.Attributes.attribute "type" "hidden", name "_csrf_token", value model.flags.csrf ] []
                    , Component.Stats.View.view
                    ]
                ]
            Nothing ->
                [ Navbar.formItem [ ]
                    [ Button.linkButton [ Button.attrs [ href "/#/auth/signin" ] ] [ text "Sign in" ]
                    , Component.Stats.View.view
                    ]
                ]

        navbarItems = case model.session.user of
            Just _ ->
                [ Navbar.itemLink [ href "/#/map" ] [ text "Map" ]
                ]
            Nothing ->
                []

        customItems = signout
    in
        div []
            [ Navbar.config Msg.NavbarMsg
                |> Navbar.withAnimation
                |> Navbar.brand
                    [ href "/#/" ]
                    [ img
                        [ src (Assets.path <| Assets.net)
                        , class "d-inline-block"
                        , style
                            [ ( "width", "30px" )
                            , ( "margin-right", "15px" )
                            ]
                        ]
                        []
                    , text "The Scratch"
                    ]
                |> Navbar.items navbarItems
                |> Navbar.customItems customItems
                |> Navbar.view model.navbar.state
            ]
