module Request.Application exposing (..)

import Data.Application exposing (..)
import Http
import Request.Api exposing (apiUrl)


appsUrl : String
appsUrl =
    apiUrl ++ "/applications"


appUrl : AppId -> String
appUrl appid =
    appsUrl ++ "/" ++ appidStr appid


winnersUrl : String
winnersUrl =
    apiUrl ++ "/winners"


listApps : Http.Request (List App)
listApps =
    Http.get appsUrl appsDecoder


retrieveApp : AppId -> Http.Request App
retrieveApp appid =
    Http.get (appUrl appid) decoder


listWinners : Http.Request (List App)
listWinners =
    Http.get winnersUrl appsDecoder
