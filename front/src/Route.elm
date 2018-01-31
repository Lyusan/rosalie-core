module Route exposing (..)

import Data.News exposing (NewsId, newsidParser)
import Navigation exposing (Location)
import UrlParser exposing (Parser, (</>), s, map, oneOf, parseHash)


type Route
    = NewsFeed
    | News NewsId
    | NotFound


route : Parser (Route -> a) a
route =
    oneOf
        [ map NewsFeed (s "")
        , map News (s "" </> newsidParser)
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash route location) of
        Just route ->
            route

        Nothing ->
            NotFound
