module Component.Stats.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)


view : String -> Html msg
view statsId =
    div
        [ id statsId
        , style
            [ ( "background-color", "red" )
            , ( "height", "40px" )
            , ( "width", "80px" )
            , ( "margin-left", "10px" )
            ]
        ]
        [ canvas
            [ id (statsId ++ "-canvas" )
            , style
                [ ( "width", "100%" )
                , ( "height", "100%" )
                ]
            ]
            []
        ]
