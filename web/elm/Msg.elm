module Msg exposing (..)

import Bootstrap.Carousel as Carousel
import Bootstrap.Navbar as Navbar
import Navigation
import Phoenix.Socket
import Data.User as User
import Route


type Msg
    = Inc
    | Dec
    | CarouselMsg Carousel.Msg
    | NavbarMsg Navbar.State
    | UrlChange Navigation.Location
    | SetRoute (Maybe Route.Route)
    | SetUser (Maybe User.User)
    | PhoenixMsg (Phoenix.Socket.Msg Msg)
