module Component.Window.Helper exposing(getWindowSize)

-- Core Imports
import Task

-- Library Imports
import Window

-- Local Imports
import Component.Application.Msg as Msg

getWindowSize : Cmd Msg.Msg
getWindowSize =
    Task.perform (\s -> Msg.WindowResize s) Window.size
