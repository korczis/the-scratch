module Application exposing (..)

-- Core Imports
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Decode exposing (Value)

-- Library Imports
import Bootstrap.Alert as Alert
import Bootstrap.Button as Button
import Bootstrap.Carousel as Carousel exposing (defaultStateOptions)
import Bootstrap.Carousel.Slide as Slide
import Bootstrap.Form.Input as Input
import Bootstrap.Grid as Grid
import Bootstrap.Navbar as Navbar
import FontAwesome.Web as Icon
import Navigation
import Phoenix.Socket
import Random
import Task
import Window

-- Local Imports
import Assets
import Data.Session as Session
import Data.User as User
import Http
import HttpBuilder
import Msg
import Model exposing (Model)
import Component.Page.Component
import Component.Home.View
import Component.Map.Model
import Component.Map.View
import Component.Navbar.View
import Component.NotFound.View
import Component.SignIn.View
import Component.SignUp.View
import Ports
import Route
import Util exposing ((=>))


socketServer : String
socketServer =
    "ws://localhost:4000/socket/websocket"

-- INIT

fetchAuthUser : Http.Request User.User
fetchAuthUser =
  Http.get "/auth/user" User.decoder

getAuthUser : Cmd Msg.Msg
getAuthUser =
  Http.send Msg.AuthUser fetchAuthUser

getWindowSize : Cmd Msg.Msg
getWindowSize =
    Task.perform (\s -> Msg.WindowResize s) Window.size

init : Value -> Navigation.Location -> ( Model, Cmd Msg.Msg )
init value location =
    let
        ( navbarState, navbarCmd ) =
            Navbar.initialState Msg.NavbarMsg
        ( routeState, routeCmd ) =
            setRoute (Route.fromLocation location)
                { history = [ location ]
                , counter = 0
                , navbar =
                    { state = navbarState
                    }
                , carousel = Carousel.initialStateWithOptions
                    { defaultStateOptions
                    | interval = Just 5000 -- Change slide every 5 seconds
                    , pauseOnHover = False -- Prevent the default behavior to pause the transitions on mouse hover
                    }
                , page = Component.Page.Component.Loaded Component.Page.Component.initialPage
                , session =
                    {
                    user = Nothing
                    , socket = Phoenix.Socket.init socketServer
                        |> Phoenix.Socket.withDebug
                    }
                , map =
                    { latitude = 48.2082
                    , longitude = 16.3738
                    }
                , window =
                    {
                        size = Nothing
                    }
                }

    in

        ( routeState
        , Cmd.batch [ navbarCmd, routeCmd, getWindowSize, getAuthUser ] -- (Task.perform identity << Task.succeed) Msg.FetchUser
        )



-- UPDATE

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
            ( { model | page = Component.Page.Component.Loaded (toModel newModel) }, Cmd.map toMsg newCmd )

        -- errored = pageErrored model
    in
   case maybeRoute of
        Nothing ->
            { model | page = Component.Page.Component.Loaded Component.Page.Component.NotFound } => Cmd.none

        Just Route.Home ->
            { model | page = Component.Page.Component.Loaded Component.Page.Component.Home } => Cmd.none

        Just Route.Map ->
            { model | page = Component.Page.Component.Loaded Component.Page.Component.Map } => Cmd.none

        Just Route.SignIn ->
            { model | page = Component.Page.Component.Loaded Component.Page.Component.SignIn } => Cmd.none

        Just Route.SignUp ->
            { model | page = Component.Page.Component.Loaded Component.Page.Component.SignUp } => Cmd.none

update : Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
update msg model =
    updatePage (Component.Page.Component.getPage model.page) msg model


updatePage : Component.Page.Component.Page -> Msg.Msg -> Model -> ( Model, Cmd Msg.Msg )
updatePage page msg model =
    let
        session =
            model.session

        toPage toModel toMsg subUpdate subMsg subModel =
            let
                ( newModel, newCmd ) =
                    subUpdate subMsg subModel
            in
                ( { model | page = Component.Page.Component.Loaded (toModel newModel) }, Cmd.map toMsg newCmd )

        -- errored =  pageErrored model
    in
        case ( msg, page ) of
            ( Msg.NoOp, _ ) ->
                ( model, Cmd.none )

            ( Msg.CarouselMsg subMsg, _ ) ->
                { model | carousel = Carousel.update subMsg model.carousel } ! []

            ( Msg.AuthUser (Ok user), _) ->
                { model | session = { session | user = Just user } } => Cmd.none

            ( Msg.AuthUser (Err _), _) ->
                ( model, Cmd.none )

            ( Msg.NavbarMsg state, _ ) ->
                let
                    modelNavbar =
                        model.navbar
                in
                    { model | navbar = { modelNavbar | state = state } } ! []

            ( Msg.UrlChange location, _ ) ->
                ( { model | history = location :: model.history }
                , Cmd.none
                )

            ( Msg.SetRoute route, _ ) ->
                setRoute route model

            ( Msg.SetLatLong lat long , _ ) ->
                ( { model | map = { longitude = long, latitude = lat } } , Cmd.none)

            ( Msg.SetUser user, _ ) ->
                let
                    session =
                        model.session

                    cmd =
                        -- If we just signed out, then redirect to Home.
                        if session.user /= Nothing && user == Nothing then
                            Route.modifyUrl Route.Home
                        else
                            Cmd.none
                in
                    { model | session = { session | user = user } }
                        => cmd

            (Msg.PhoenixMsg msg, _) ->
               let
                session =
                    model.session

                ( phxSocket, phxCmd ) =
                    Phoenix.Socket.update msg model.session.socket
               in
                 ( { model | session = { session | socket = phxSocket } }
                 , Cmd.map Msg.PhoenixMsg phxCmd
                 )

            (Msg.WindowResize size, _) ->
                let
                    window =
                        model.window
                in
                    { model | window = { window | size = Just size } } ! []


viewPage : Model.Model -> Html Msg.Msg
viewPage model =
    let
        page = model.page
    in
        case page of
            Component.Page.Component.Loaded Component.Page.Component.Blank ->
                div [] [ text "Blank" ]

            Component.Page.Component.Loaded Component.Page.Component.Home ->
                Component.Home.View.view model.carousel

            Component.Page.Component.Loaded Component.Page.Component.Map ->
                Component.Map.View.view model.window

            Component.Page.Component.Loaded Component.Page.Component.NotFound ->
                Component.NotFound.View.view

            Component.Page.Component.Loaded Component.Page.Component.SignIn ->
                Component.SignIn.View.view

            Component.Page.Component.Loaded Component.Page.Component.SignUp ->
                Component.SignUp.View.view

            Component.Page.Component.TransitioningFrom _ ->
                div [] []

view : Model -> Html Msg.Msg
view model =
    div []
        [ Component.Navbar.View.view model -- Interactive and responsive menu
        , viewPage model

        -- , mainContent model
        ]



-- If you use animations as above or you use dropdowns in your navbar you need to configure subscriptions too


subscriptions : Model -> Sub Msg.Msg
subscriptions model =
    Sub.batch
        [ Navbar.subscriptions model.navbar.state Msg.NavbarMsg
        , Sub.map Msg.SetUser sessionChange
        , Phoenix.Socket.listen model.session.socket Msg.PhoenixMsg
        , Carousel.subscriptions model.carousel Msg.CarouselMsg
        , Window.resizes Msg.WindowResize
        ]


sessionChange : Sub (Maybe User.User)
sessionChange =
    Ports.onSessionChange (Decode.decodeValue User.decoder >> Result.toMaybe)


viewLink : String -> Html msg
viewLink name =
    li [] [ a [ href ("#" ++ name) ] [ text name ] ]


viewLocation : Navigation.Location -> Html msg
viewLocation location =
    li [] [ text (location.pathname ++ location.hash) ]
