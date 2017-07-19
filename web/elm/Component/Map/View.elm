module Component.Map.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing(..)
import Html.Events exposing (..)
import Json.Encode as Encode exposing (..)
import Json.Decode as Decode exposing (..)
import Window

import Component.Application.Msg as Msg
import Component.Map.Model exposing (Model)
import Component.Map.Msg

googleMap : List (Attribute a) -> List (Html a) -> Html a
googleMap =
    Html.node "google-map"

view : Model -> Maybe Window.Size -> Html Msg.Msg
view model windowSize =
    let
        size = Maybe.withDefault ( Window.Size 0 0 ) windowSize
        height = toString (size.height - 56) ++ "px"

    in
        div [style [("background-color", "red"), ("width", "100%"), ("height", height)]] [
            googleMap
                [ property "disableMapTypeControl" (Encode.bool True)
                , property "disableStreetViewControl" (Encode.bool True)
                , property "latitude" (Encode.float model.latitude)
                , property "longitude" (Encode.float model.longitude)
                , property "zoom" (Encode.int model.zoom)
                , attribute "drag-events" "true"
                , attribute "map-type" "satellite"
                -- , attribute "api-key" "AIzaSyC0KVspAlR2NqQIU-1k0zyNlmRURbbgPr0"
                , recordIdle
                -- , recordLatLongOnDrag
                -- , recordZoomChange
                ] [ ]
        ]

recordIdle : Attribute Msg.Msg
recordIdle =
    on "google-map-idle" <|
        map3 Msg.SetLatLongZoom
            (at [ "target", "latitude" ] Decode.float)
            (at [ "target", "longitude" ] Decode.float)
            (at [ "target", "zoom" ] Decode.int)

recordLatLongOnDrag : Attribute Msg.Msg
recordLatLongOnDrag =
    on "google-map-drag" <|
        map3 Msg.SetLatLongZoom
            (at [ "target", "latitude" ] Decode.float)
            (at [ "target", "longitude" ] Decode.float)
            (at [ "target", "zoom" ] Decode.int)

recordZoomChange : Attribute Msg.Msg
recordZoomChange =
    on "google-map-drag" <|
        map3 Msg.SetLatLongZoom
            (at [ "target", "latitude" ] Decode.float)
            (at [ "target", "longitude" ] Decode.float)
            (at [ "target", "zoom" ] Decode.int)
