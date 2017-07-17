module Msg exposing (..)

import Bootstrap.Carousel as Carousel
import Bootstrap.Navbar as Navbar
import Http
import Navigation
import Window
import Phoenix.Socket
import Data.User as User
import Route

type Msg
    = NoOp
    | AuthUser (Result Http.Error String)
    | CarouselMsg Carousel.Msg
    | NavbarMsg Navbar.State
    | PhoenixMsg (Phoenix.Socket.Msg Msg)
    | SetRoute (Maybe Route.Route)
    | SetUser (Maybe User.User)
    | UrlChange Navigation.Location
    | WindowResize Window.Size
    | SetLatLong Float Float
