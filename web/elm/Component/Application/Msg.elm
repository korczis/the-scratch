module Component.Application.Msg exposing(..)

import Bootstrap.Carousel as Carousel
import Bootstrap.Navbar as Navbar
import Http
import Navigation
import Window
import Phoenix.Socket
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
    | SetLatLongZoom Float Float Int
    -- | MapMsg Component.Map.Msg.Msg
