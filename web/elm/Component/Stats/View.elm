module Component.Stats.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


view : Html msg
view =
    div
        [ id "stats"
        , style
            [ ( "background-color", "red" )
            , ( "height", "48px" )
            , ( "width", "80px" )
            , ( "margin-left", "10px" )
            ]
        ]
        [ canvas
            [ style
                [ ( "width", "100%" )
                , ( "height", "100%" )
                ]
            ]
            []
        ]
