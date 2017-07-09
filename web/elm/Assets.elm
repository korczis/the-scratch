module Assets exposing (..)


type AssetPath
    = AssetPath String


net =
    AssetPath "../../priv/static/images/net.svg"


path : AssetPath -> String
path (AssetPath str) =
    str
