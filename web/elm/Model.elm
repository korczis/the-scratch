module Model exposing (Model)

-- Library Imports
import Bootstrap.Carousel as Carousel
import Bootstrap.Navbar as Navbar
import Navigation
import Window
-- Local Imports
import Data.Session as Session
import Page
import Component.Home.Model


-- MODEL


type alias Model =
    { history : List Navigation.Location
    , navbar :
        { state : Navbar.State
        }
    , carousel : Component.Home.Model.Model
    , counter : Int
    , page : Page.State
    , session : Session.Session
    , map :
        { latitude : Float
        , longitude : Float
        }
    , window :
        { size : Maybe Window.Size
        }
    }
