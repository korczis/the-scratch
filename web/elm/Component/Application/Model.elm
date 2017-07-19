module Component.Application.Model exposing (Model)

-- Library Imports
import Navigation
import Window

-- Local Imports
import Data.Session as Session
import Component.Page.Component
import Component.Home.Model
import Component.Map.Model
import Component.Navbar.Model

type alias Model =
    { history : List Navigation.Location
    , navbar : Component.Navbar.Model.Model
    , carousel : Component.Home.Model.Model
    , page : Component.Page.Component.State
    , session : Session.Session
    , map : Component.Map.Model.Model
    , window :
        { size : Maybe Window.Size
        }
    }
