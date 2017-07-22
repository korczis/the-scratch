module Data.User exposing (User, decoder, encode)

import Html exposing (Html)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline exposing (decode, required)
import Json.Encode as Encode exposing (Value)
import Json.Encode.Extra as EncodeExtra
import UrlParser
import Util exposing ((=>))


type alias User =
    { email : String
    }



-- SERIALIZATION --


decoder : Decoder User
decoder =
    decode User
        |> required "email" Decode.string

encode : User -> Value
encode user =
    Encode.object
        [ "email" => Encode.string user.email
        ]
