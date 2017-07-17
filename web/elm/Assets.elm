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

snFacebook128 =
    AssetPath "../../priv/static/images/social/facebook_128.png"

snGithub128 =
    AssetPath "../../priv/static/images/social/github_128.png"

snGoogle128 =
    AssetPath "../../priv/static/images/social/google_128.png"

snLinkedin128 =
    AssetPath "../../priv/static/images/social/linkedin_128.png"

snTwitter128 =
    AssetPath "../../priv/static/images/social/twitter_128.png"

path : AssetPath -> String
path (AssetPath str) =
    str
