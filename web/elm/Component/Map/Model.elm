module Component.Map.Model exposing (..)

import Window

type alias Model =
    { latitude : Float
    , longitude : Float
    , zoom: Int
    }
