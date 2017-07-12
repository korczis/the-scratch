module Assets exposing (..)


type AssetPath
    = AssetPath String


net =
    AssetPath "../../priv/static/images/net.svg"

kitten1 =
   AssetPath "../../priv/static/images/kittens/kitten-1.jpg"

kitten2 =
   AssetPath "../../priv/static/images/kittens/kitten-2.jpg"

kitten3 =
   AssetPath "../../priv/static/images/kittens/kitten-3.jpg"

kitten4 =
   AssetPath "../../priv/static/images/kittens/kitten-4.jpg"

kitten5 =
   AssetPath "../../priv/static/images/kittens/kitten-5.jpg"

path : AssetPath -> String
path (AssetPath str) =
    str
