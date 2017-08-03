module  Component.Application.Helper exposing(socketServer)

-- TODO: Generate programatically
socketServer : String -> String
socketServer token =
    "ws://localhost:4000/socket/websocket?token=" ++ token
