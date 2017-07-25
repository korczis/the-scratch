module Component.Application.Msg exposing(..)

-- Core Imports
import Http
import Time

-- Library Imports
import Bootstrap.Carousel as Carousel
import Bootstrap.Navbar as Navbar
import Navigation
import Phoenix.Socket
import Window

-- Local Imports
import Data.User as User
import Route

import Component.Map.Msg

type Msg
    = NoOp
    | AuthUser (Result Http.Error User.User)
    | CarouselMsg Carousel.Msg
    | NavbarMsg Navbar.State
    | PhoenixMsg (Phoenix.Socket.Msg Msg)
    | SetRoute (Maybe Route.Route)
    | SetUser (Maybe User.User)
    | UrlChange Navigation.Location
    | WindowResize Window.Size
    | SendToJs String
    | SetLatLongZoom Float Float Int
    | SetMapType String
    | SignOut
    | Tick Time.Time
    -- | MapMsg Component.Map.Msg.Msg
