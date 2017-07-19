module Component.Navbar.Model exposing(Model)

import Bootstrap.Navbar as Navbar

type alias Model =
    { state : Navbar.State
    }
