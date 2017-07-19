module Main exposing (..)

-- Library Imports
import TimeTravel.Navigation as TimeTravel

-- Local Imports
import Component.Application.Init exposing(init)
import Component.Application.Msg as Msg
import Component.Application.Update exposing(update)
import Component.Application.View exposing(view)
import Component.Application.Subscription exposing(subscriptions)
import Route

main =
    TimeTravel.programWithFlags (Route.fromLocation >> Msg.SetRoute)
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
