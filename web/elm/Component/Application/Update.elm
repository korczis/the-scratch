module Component.Application.Update exposing(update)

-- Library Imports
import Bootstrap.Carousel as Carousel
import Phoenix.Socket

-- Local Imports
import Component.Application.Model exposing(Model)
import Component.Application.Msg as Msg
import Component.Application.Init exposing(setRoute)
import Component.Page.Component
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

    in
        case ( msg, page ) of
            ( Msg.NoOp, _ ) ->
                ( model, Cmd.none )

            ( Msg.CarouselMsg subMsg, _ ) ->
                { model | carousel = Carousel.update subMsg model.carousel } ! []

            ( Msg.AuthUser (Ok user), _) ->
                { model | session = { session | user = Just user } } => Cmd.none

            ( Msg.SignOut, _) ->
                { model | session = { session | user = Nothing} } => Cmd.none

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

            ( Msg.SetLatLongZoom lat long zoom , _ ) ->
                ( { model | map = { longitude = long, latitude = lat, zoom = zoom } } , Cmd.none)

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
