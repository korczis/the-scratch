module Component.Application.Update exposing(update)

-- Library Imports
import Bootstrap.Carousel as Carousel
import Phoenix.Socket

-- Local Imports
import Component.Application.Helper exposing(socketServer)
import Component.Application.Model exposing(Model)
import Component.Application.Msg as Msg
import Component.Application.Init exposing(setRoute)
import Component.Page.Component
import Ports exposing(toJs)
import Route
import Util exposing ((=>))

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

        origin = case List.head model.history of
            Just history ->
                history.origin
            Nothing ->
                "http://localhost:4000"

    in
        case ( msg, page ) of
            ( Msg.NoOp, _ ) ->
                ( model, Cmd.none )

            ( Msg.CarouselMsg subMsg, _ ) ->
                { model | carousel = Carousel.update subMsg model.carousel } ! []

            ( Msg.AuthUser (Just (user, jwt)), _) ->
                let
                    socket = Just (Phoenix.Socket.init (socketServer origin jwt)|> Phoenix.Socket.withDebug)
                in
                    { model | session = { session | user = Just user,  socket = socket, token = Just jwt } } => Cmd.none

            ( Msg.AuthUser (Nothing), _) ->
                ( model, Cmd.none )

            ( Msg.SignOut, _) ->
                { model | session = { session | user = Nothing, socket = Nothing } } => Cmd.none


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

            ( Msg.SendToJs str, _ ) ->
                ( model, toJs str )

            ( Msg.SetRoute route, _ ) ->
                setRoute route model

            ( Msg.SetLatLongZoom lat long zoom , _ ) ->
                let
                    modelMap = model.map
                in
                    ( { model | map = { modelMap | longitude = long, latitude = lat, zoom = zoom } } , Cmd.none)

            ( Msg.SetMapType typ , _ ) ->
                let
                    modelMap = model.map
                in
                    ( { model | map = { modelMap | mapType = typ } } , Cmd.none)

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

            ( Msg.PhoenixMsg msg, _ ) ->
               let
                session =
                    model.session

                socketMsg = case model.session.socket of
                    Just socket ->
                        Just (Phoenix.Socket.update msg socket)
                    Nothing ->
                        Nothing
               in
                case socketMsg of
                    Just ( phxSocket, phxCmd ) ->
                     ( { model | session = { session | socket = Just phxSocket } }
                     , Cmd.map Msg.PhoenixMsg phxCmd
                     )
                    Nothing ->
                        ( model, Cmd.none )

            ( Msg.Tick delta, _ ) ->
                ( model, Cmd.none )

            ( Msg.WindowResize size, _ ) ->
                let
                    window =
                        model.window
                in
                    { model | window = { window | size = Just size } } ! []
