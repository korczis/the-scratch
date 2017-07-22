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
  -- eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJVc2VyOjUiLCJleHAiOjE1MDMyMzQzMDksImlhdCI6MTUwMDY0MjMwOSwiaXNzIjoiV2ViU3BhIiwianRpIjoiNDllMDUwNWMtNDY1Yy00MmU1LThhMDktOGVmYmZlM2I5OTk5IiwicGVtIjp7fSwic3ViIjoiVXNlcjo1IiwidHlwIjoiYWNjZXNzIn0.7O6fx7yKWFV1eQ9GUNOoqRjg47oPZIgtmok3ZQYp0va24JfqFBXElz-ELCj2WfwLQYc3xIbxhQQI-WCvAKWxyg
  Http.send Msg.AuthUser fetchAuthUser
