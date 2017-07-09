module Page exposing (..)

import Page.Home


type Page
    = Blank
    | NotFound
    | Home -- Page.Home.Model
    | Map


type State
    = Loaded Page
    | TransitioningFrom Page


initialPage : Page
initialPage =
    Blank


getPage : State -> Page
getPage pageState =
    case pageState of
        Loaded page ->
            page

        TransitioningFrom page ->
            page
