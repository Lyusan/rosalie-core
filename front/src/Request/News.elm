module Request.News exposing (..)

import Http
import Data.News exposing (..)
import Request.Api exposing (apiUrl)


feedUrl : String
feedUrl =
    apiUrl ++ "/news"


newsUrl : NewsId -> String
newsUrl nid =
    feedUrl ++ "/" ++ (nidStr nid)


listNews : Http.Request (List News)
listNews =
    Http.get feedUrl feedDecoder


retrieveNews : NewsId -> Http.Request News
retrieveNews nid =
    Http.get (newsUrl nid) decoder
