module Component.Application.Init exposing(init, setRoute)

-- Core Imports
import Http
import Task

-- Library Imports
import Bootstrap.Carousel as Carousel exposing (defaultStateOptions)
import Bootstrap.Navbar as Navbar
import Navigation
import Json.Decode as Decode exposing (..)
import Phoenix.Socket
import Window

-- Local Imports
import Component.Application.Flags
import Component.Application.Model exposing(Model)
import Component.Application.Msg as Msg
import Component.Auth.Helper exposing(getAuthUser)
import Component.Map.Init
import Component.Page.Component as Page
import Component.Window.Helper exposing(getWindowSize)
import Data.User as User

import Route
import Util exposing ((=>))

setRoute : Maybe Route.Route -> Model -> ( Model, Cmd Msg.Msg )
setRoute maybeRoute model =
    let
        session =
            model.session

        toPage toModel toMsg subUpdate subMsg subModel =
            let
                ( newModel, newCmd ) =
                    subUpdate subMsg subModel
            in
            ( { model | page = Page.Loaded (toModel newModel) }, Cmd.map toMsg newCmd )
    in
   case maybeRoute of
        Nothing ->
            { model | page = Page.Loaded Page.NotFound } => Cmd.none

        Just Route.GraphQL ->
            { model | page = Page.Loaded Page.GraphQL } => Cmd.none

        Just Route.Home ->
            { model | page = Page.Loaded Page.Home } => Cmd.none

        Just Route.Map ->
            { model | page = Page.Loaded Page.Map } => Cmd.none

        Just Route.Profile ->
            { model | page = Page.Loaded Page.Profile } => Cmd.none

        Just Route.SignIn ->
            { model | page = Page.Loaded Page.SignIn } => Cmd.none

        Just Route.SignUp ->
            { model | page = Page.Loaded Page.SignUp } => Cmd.none

send : msg -> Cmd msg
send msg =
  Task.succeed msg
  |> Task.perform identity

type alias Flags =
  { csrf : String
  }

init : Value -> Navigation.Location -> ( Model, Cmd Msg.Msg )
init value location =
    let
        ( navbarState, navbarCmd ) =
            Navbar.initialState Msg.NavbarMsg

        initFlags = case (decodeValue Component.Application.Flags.decoder value) of
            Ok (res) ->
                res
            _ ->
                Component.Application.Flags.defaultFlags

        ( routeState, routeCmd ) =
            setRoute (Route.fromLocation location)
                { flags = initFlags
                , history = [ location ]
                , navbar =
                    { state = navbarState
                    }
                , carousel = Carousel.initialStateWithOptions
                    { defaultStateOptions
                    | interval = Just 5000 -- Change slide every 5 seconds
                    , pauseOnHover = False -- Prevent the default behavior to pause the transitions on mouse hover
                    }
                , page = Page.Loaded Page.initialPage
                , session =
                    { user = Nothing
                    , socket = Nothing
                    , token = Nothing
                    }
                , map = Component.Map.Init.init
                , window =
                    { size = Nothing
                    }
                }

    in

        ( routeState
        , Cmd.batch
            [ navbarCmd
            , routeCmd
            , getWindowSize
            , getAuthUser
            , send (Msg.SendToJs "Hello World!")
           ]
        )
