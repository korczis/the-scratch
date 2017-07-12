module Page.SignIn exposing (Model, view)

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Html exposing (..)
import Html.Attributes exposing (..)
import Assets
import Msg

type alias Model =
    {}


view : Html Msg.Msg
view =
    Grid.container [ class "justify-content-md-center" ]
        [ Grid.row
            [ Row.centerXs ]
            [ Grid.col
                [ Col.middleXs
                , Col.xs8
                , Col.attrs [ style [ ( "text-align", "center" ) ] ] ]
                [ a [ href "#" ] [img [ src (Assets.path <| Assets.snFacebook128) ] [] ]
                , a [ href "#" ] [img [ src (Assets.path <| Assets.snGithub128) ] [] ]
                , a [ href "#" ] [img [ src (Assets.path <| Assets.snGoogle128) ] [] ]
                , a [ href "#" ] [img [ src (Assets.path <| Assets.snLinkedin128) ] [] ]
                , a [ href "#" ] [img [ src (Assets.path <| Assets.snTwitter128) ] [] ]
                ]
            ]
        ]
