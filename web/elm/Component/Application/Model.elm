module Component.Application.Model exposing (Model)

-- Library Imports
import Window

-- Local Imports
import Data.Session as Session
import Component.Page.Component
import Component.Home.Model
import Component.History.Model
import Component.Map.Model
import Component.Navbar.Model
import Component.Window.Model

type alias Model =
    { history : Component.History.Model.Model
    , navbar : Component.Navbar.Model.Model
    , carousel : Component.Home.Model.Model
    , page : Component.Page.Component.State
    , session : Session.Session
    , map : Component.Map.Model.Model
    , window : Component.Window.Model.Model
    }
