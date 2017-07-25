module Component.Application.Flags exposing(..)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline as Pipeline exposing (decode, required)

type alias Flags =
    { csrf : String
    }

defaultFlags : Flags
defaultFlags =
    { csrf = ""
    }

decoder : Decoder Flags
decoder =
    decode Flags
        |> required "csrf" Decode.string
