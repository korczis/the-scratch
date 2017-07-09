module Model exposing (Model)

import Bootstrap.Navbar as Navbar
import Data.Session as Session
import Navigation
import Page


-- MODEL


type alias Model =
    { history : List Navigation.Location
    , navbar :
        { state : Navbar.State
        }
    , counter : Int
    , page : Page.State
    , session : Session.Session
    }
