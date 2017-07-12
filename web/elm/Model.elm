module Model exposing (Model)

import Bootstrap.Carousel as Carousel
import Bootstrap.Navbar as Navbar
import Data.Session as Session
import Navigation
import Page
import Page.Home as Home


-- MODEL


type alias Model =
    { history : List Navigation.Location
    , navbar :
        { state : Navbar.State
        }
    , carousel : Home.Model
    , counter : Int
    , page : Page.State
    , session : Session.Session
    }
