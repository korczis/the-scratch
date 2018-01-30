module Component.Application.Flags exposing(..)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline exposing (decode, required)

type alias Flags =
    { csrf : String
      , debug : String
    }

defaultFlags : Flags
defaultFlags =
    { csrf = ""
      , debug = ""
    }

decoder : Decoder Flags
decoder =
    decode Flags
        |> required "csrf" Decode.string
        |> required "debug" Decode.string
