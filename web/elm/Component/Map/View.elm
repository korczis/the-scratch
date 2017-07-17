module Component.Map.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing(..)
import Html.Events exposing (..)
import Json.Decode as Decode exposing (..)

import Component.Map.Model exposing (Model)
import Msg exposing (Msg)

googleMap : List (Attribute a) -> List (Html a) -> Html a
googleMap =
    Html.node "google-map"

view : Model -> Html Msg.Msg
view model =
    let
        height = "600px"

    in
        div [style [("background-color", "red"), ("width", "100%"), ("height", height)]] [
            googleMap
                [attribute "latitude" "0"
                , attribute "longitude" "0"
                , attribute "drag-events" "true"
                , attribute "map-type" "satellite"
                , attribute "zoom" "3"
                , recordLatLongOnDrag
                ] [ div [ ] [ text "this is test" ] ]
        ]

recordLatLongOnDrag : Attribute Msg.Msg
recordLatLongOnDrag =
    on "google-map-drag" <|
        map2 Msg.SetLatLong
            (at [ "target", "latitude" ] float)
            (at [ "target", "longitude" ] float)
