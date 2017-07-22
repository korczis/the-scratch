module Component.Navbar.View exposing (..)

-- Library Imports
import Bootstrap.Button as Button
import Bootstrap.Form.Input as Input
import Html.Attributes exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)
import Bootstrap.Navbar as Navbar

-- Local Imports
import Assets
import Component.Application.Model exposing(Model)
import Component.Application.Msg as Msg
import Port.AnimationFrame

view : Model -> Html Msg.Msg
view model =
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
                , text "Web SPA"
                ]
            |> Navbar.items
                [ Navbar.itemLink [ href "/#/map" ] [ text "Map" ]
                , Navbar.itemLink [ href "/#/auth/signin" ] [ text "Sign in" ]
                , Navbar.itemLink [ href "/#/auth/signup" ] [ text "Sign up" ]
                ]
            |> Navbar.customItems
                [ Navbar.formItem []
                    [ Button.button [ Button.attrs [ onClick Msg.SignOut, href "javascript:void(0);" ] ] [ text "Sign out" ]
                    ]
                ]
--            |> Navbar.customItems
--                -- Add custom items
--                [ Navbar.formItem []
--                    [ Input.text [ Input.attrs <| [ placeholder "enter" ] ]
--                    , Button.button
--                        [ Button.success
--                        , Button.attrs [ class "ml-sm-2" ]
--                        ]
--                        [ text "Search" ]
--                    ]
--                , Navbar.textItem [ class "muted ml-sm-2" ] [ text "Sign in" ]
--                , Navbar.textItem [ class "muted ml-sm-2" ] [ text "Sign up" ]
--                ]
            |> Navbar.view model.navbar.state
        ]
