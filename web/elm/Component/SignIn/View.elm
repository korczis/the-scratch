module Component.SignIn.View exposing (..)

-- Core Imports
import Html exposing (..)
import Html.Attributes exposing (..)

-- Library Imports
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row

-- Local Imports
import Assets
import Component.Application.Msg as Msg

view : Html Msg.Msg
view =
    Grid.container [ class "justify-content-md-center" ]
        [ Grid.row
            [ Row.centerXs ]
            [ Grid.col
                [ Col.middleXs
                , Col.xs8
                , Col.attrs [ style [ ( "text-align", "center" ) ] ] ]
                [ a [ href "/auth/facebook" ] [img [ src (Assets.path <| Assets.snFacebook128) ] [] ]
                , a [ href "/auth/github" ] [img [ src (Assets.path <| Assets.snGithub128) ] [] ]
                , a [ href "/auth/google" ] [img [ src (Assets.path <| Assets.snGoogle128) ] [] ]
                , a [ href "/auth/linkedin" ] [img [ src (Assets.path <| Assets.snLinkedin128) ] [] ]
                , a [ href "/auth/twitter" ] [img [ src (Assets.path <| Assets.snTwitter128) ] [] ]
                ]
            ]
        ]
