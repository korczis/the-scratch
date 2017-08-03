module  Component.Auth.Helper exposing(getAuthUser)

-- Core Imports
import Dict
import Http
import HttpBuilder exposing (..)
import Http.Extra exposing (..)
import Json.Decode as Decode

-- Library Imports
import Component.Application.Msg as Msg
import Data.User as User

handleRequestComplete : Result Http.Error (Http.Response User.User) -> Msg.Msg
handleRequestComplete result =
    case result of
        (Ok response) ->
            let
                header = Dict.get "jwt" response.headers
            in
                case header of
                    (Just jwt) ->
                        Msg.AuthUser (Just (response.body, jwt))
                    Nothing ->
                        Msg.AuthUser Nothing
        (Err _) ->
            Msg.AuthUser Nothing

getAuthUser : Cmd Msg.Msg
getAuthUser =
  -- Http.send Msg.AuthUser fetchAuthUser
  HttpBuilder.get "/auth/user"
      |> withExpect (Http.Extra.expectJsonResponse User.decoder)
      |> send handleRequestComplete
