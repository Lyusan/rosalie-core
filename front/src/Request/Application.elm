module Request.Application
    exposing
        ( listApps
        , retrieveApp
        , listWinners
        )

import Data.Application exposing (App, AppId, appidStr, appsDecoder, decoder)
import Request.Api exposing (apiUrl)
import Http


listApps : Http.Request (List App)
listApps =
    Http.get appsUrl appsDecoder


retrieveApp : AppId -> Http.Request App
retrieveApp appid =
    Http.get (appUrl appid) decoder


listWinners : Http.Request (List App)
listWinners =
    Http.get winnersUrl appsDecoder



-- INTERNALS --


appsUrl : String
appsUrl =
    apiUrl ++ "/applications"


appUrl : AppId -> String
appUrl appid =
    appsUrl ++ "/" ++ appidStr appid


winnersUrl : String
winnersUrl =
    apiUrl ++ "/winners"
