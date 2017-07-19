module Model exposing (Model)

-- Library Imports
import Bootstrap.Carousel as Carousel
import Bootstrap.Navbar as Navbar
import Navigation
import Window

-- Local Imports
import Data.Session as Session
import Component.Page.Component
import Component.Home.Model
import Component.Map.Model

type alias Model =
    { history : List Navigation.Location
    , navbar :
        { state : Navbar.State
        }
    , carousel : Component.Home.Model.Model
    , counter : Int
    , page : Component.Page.Component.State
    , session : Session.Session
    , map : Component.Map.Model.Model
    , window :
        { size : Maybe Window.Size
        }
    }
