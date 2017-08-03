module  Component.Application.Helper exposing(socketServer)

import String.Extra exposing(replace)

-- TODO: Generate programatically
socketServer : String -> String -> String
socketServer origin token =
    (replace "http" "ws" origin) ++ "/socket/websocket?token=" ++ token
