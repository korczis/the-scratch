module Component.Application.Subscription exposing(subscriptions)

-- Core Imports
import Time
-- Library Imports
import AnimationFrame
import Bootstrap.Navbar as Navbar
import Bootstrap.Carousel as Carousel
import Json.Decode as Decode
import Phoenix.Socket
import Window

-- Local Imports
import Component.Application.Model exposing(Model)
import Component.Application.Msg as Msg
import Data.User as User
import Ports

sessionChange : Sub (Maybe User.User)
sessionChange =
    Ports.onSessionChange (Decode.decodeValue User.decoder >> Result.toMaybe)

-- TODO: Compose from Component/*/Subscription.elm#subscription
subscriptions : Model -> Sub Msg.Msg
subscriptions model =
    let
        tmp =
            [ AnimationFrame.diffs (\delta -> Msg.Tick delta)
            , Navbar.subscriptions model.navbar.state Msg.NavbarMsg
            , Sub.map Msg.SetUser sessionChange
            , Carousel.subscriptions model.carousel Msg.CarouselMsg
            , Window.resizes Msg.WindowResize
            ]

        subs = case model.session.socket of
            Just socket ->
                tmp ++ [Phoenix.Socket.listen socket Msg.PhoenixMsg]
            Nothing ->
                tmp
    in
        Sub.batch subs
