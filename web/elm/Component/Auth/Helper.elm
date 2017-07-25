module  Component.Auth.Helper exposing(getAuthUser)

-- Core Imports
import Http

-- Library Imports
import Component.Application.Msg as Msg
import Data.User as User

fetchAuthUser : Http.Request User.User
fetchAuthUser =
  Http.get "/auth/user" User.decoder

getAuthUser : Cmd Msg.Msg
getAuthUser =
  Http.send Msg.AuthUser fetchAuthUser
