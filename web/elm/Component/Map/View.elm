module Component.Map.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing(..)
import Html.Events exposing (..)
import Json.Encode as Encode exposing (..)
import Json.Decode as Decode exposing (..)
import Window

import Component.Application.Msg as Msg
import Component.Map.Model exposing (Model)

googleMap : List (Attribute a) -> List (Html a) -> Html a
googleMap =
    Html.node "google-map"

view : Model -> Maybe Window.Size -> Html Msg.Msg
view model windowSize =
    let
        size = Maybe.withDefault ( Window.Size 0 0 ) windowSize
        -- TODO: Replace 56px on following line with runtime value
        height = toString (size.height - 56) ++ "px"

    in
        div [style [("background-color", "red"), ("width", "100%"), ("height", height)]] [
            googleMap
                [ property "disableMapTypeControl" (Encode.bool (not model.mapTypeControl))
                , property "disableStreetViewControl" (Encode.bool (not model.streetViewControl))
                , property "latitude" (Encode.float model.latitude)
                , property "longitude" (Encode.float model.longitude)
                , property "zoom" (Encode.int model.zoom)
                , property "drag-events" (Encode.bool True)
                , attribute "map-type" model.mapType
                -- , attribute "api-key" "AIzaSyC0KVspAlR2NqQIU-1k0zyNlmRURbbgPr0"
                , recordIdle
                , recordLatLongOnDrag
                , recordMapTypeChange
                , recordZoomChange
                ] [ ]
        ]

updateMapLatLongZoom : Decoder Msg.Msg
updateMapLatLongZoom =
    map3 Msg.SetLatLongZoom
        (at [ "target", "latitude" ] Decode.float)
        (at [ "target", "longitude" ] Decode.float)
        (at [ "target", "zoom" ] Decode.int)

updateMapType : Decoder Msg.Msg
updateMapType =
    Decode.map Msg.SetMapType
        (at [ "target", "mapType" ] Decode.string)

recordIdle : Attribute Msg.Msg
recordIdle =
    on "google-map-idle"
        <| updateMapLatLongZoom

recordLatLongOnDrag : Attribute Msg.Msg
recordLatLongOnDrag =
    on "google-map-drag"
        <| updateMapLatLongZoom

recordMapTypeChange : Attribute Msg.Msg
recordMapTypeChange =
    on "map-type-changed"
        <| updateMapType

recordZoomChange : Attribute Msg.Msg
recordZoomChange =
    on "google-map-drag"
        <| updateMapLatLongZoom
