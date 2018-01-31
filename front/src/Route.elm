module Route exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (Parser, (</>), s, map, oneOf, parseHash)


type Route
    = NewsFeed
    | News
    | NotFound


route : Parser (Route -> a) a
route =
    oneOf
        [ map NewsFeed (s "")
        , map News (s "")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash route location) of
        Just route ->
            route

        Nothing ->
            NotFound
