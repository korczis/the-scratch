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
import Data.User as User exposing (User)

view : Model -> Html Msg.Msg
view model =
    div []
        [ Navbar.config Msg.NavbarMsg
            |> Navbar.withAnimation
            |> brand
            |> Navbar.items (navbarItems model.session.user)
            |> Navbar.customItems (customItems model.session.user model.flags.csrf)
            |> Navbar.view model.navbar.state
        ]

brand : Navbar.Config msg -> Navbar.Config msg
brand =
    Navbar.brand
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

viewStats : Html msg
viewStats =
    Component.Stats.View.view "stats"

customItems : Maybe User -> String -> List (Navbar.CustomItem Msg.Msg)
customItems user csrf =
    case user of
        Just user ->
            customItemsSignedIn user csrf
        Nothing ->
            customItemsSignedOut

customItemsSignedIn : User -> String -> List (Navbar.CustomItem Msg.Msg)
customItemsSignedIn user csrf =
    [ Navbar.formItem [ action "/auth/signout", method "post" ]
        [  Button.linkButton [ Button.attrs [ href "/#/profile", style[ ("padding-right", "10px") ] ] ] [ text user.email ]
        , Button.button [ Button.attrs [ onClick Msg.SignOut, href "javascript:void(0);" ] ] [ text "Sign out" ]
        , input [ Html.Attributes.attribute "type" "hidden", name "_csrf_token", value csrf ] []
        , viewStats
        ]
    ]

customItemsSignedOut : List (Navbar.CustomItem Msg.Msg)
customItemsSignedOut =
    [ Navbar.formItem [ ]
        [ Button.linkButton [ Button.attrs [ href "/#/auth/signin" ] ] [ text "Sign in" ]
        , viewStats
        ]
    ]

navbarItems : Maybe User -> List (Navbar.Item msg)
navbarItems user =
    case user of
        Just _ ->
            navbarItemsSignedIn
        Nothing ->
            navbarItemsSignedOut

navbarItemsSignedIn : List (Navbar.Item msg)
navbarItemsSignedIn =
    [ Navbar.itemLink [ href "/#/map" ] [ text "Map" ]
    , Navbar.itemLink [ href "/#/graphql" ] [ text "GraphQL" ]
    ]

navbarItemsSignedOut : List (Navbar.Item msg)
navbarItemsSignedOut =
    []
