module Request.News exposing (listNews, retrieveNews)

import Data.News exposing (News, NewsId, nidStr, feedDecoder, decoder)
import Request.Api exposing (apiUrl)
import Http


listNews : Http.Request (List News)
listNews =
    Http.get feedUrl feedDecoder


retrieveNews : NewsId -> Http.Request News
retrieveNews nid =
    Http.get (newsUrl nid) decoder



-- INTERNALS --


feedUrl : String
feedUrl =
    apiUrl ++ "/news"


newsUrl : NewsId -> String
newsUrl nid =
    feedUrl ++ "/" ++ (nidStr nid)
