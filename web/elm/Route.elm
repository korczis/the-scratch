module Route exposing (..)

import Html exposing (Attribute)
import Html.Attributes as Attr
import Navigation exposing (Location)
import UrlParser as Url exposing ((</>), Parser, oneOf, parseHash, s, string)

-- TODO: Generate automatically
type Route
    = Home
    | GraphQL
    | Map
    | Profile
    | SignIn
    | SignUp


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Home (s "")
        , Url.map GraphQL (s "graphql")
        , Url.map Map (s "map")
        , Url.map Profile (s "profile")
        , Url.map SignIn (s "auth" </> s "signin" )
        , Url.map SignUp (s "auth" </> s "signup" )
        ]


routeToString : Route -> String
routeToString page =
    let
        pieces =
            case page of
                Home ->
                    []

                GraphQL ->
                    [ "graphql" ]

                Map ->
                    [ "map" ]

                Profile ->
                    [ "profile" ]

                SignIn ->
                    [ "auth", "signin" ]

                SignUp ->
                    [ "auth", "signup" ]

    in
        "#" ++ String.join "/" pieces



-- PUBLIC HELPERS --


href : Route -> Attribute msg
href route =
    Attr.href (routeToString route)


modifyUrl : Route -> Cmd msg
modifyUrl =
    routeToString >> Navigation.modifyUrl


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Home
    else
        parseHash route location
