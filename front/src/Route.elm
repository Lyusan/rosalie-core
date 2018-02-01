module Route exposing (Route(..), parseLocation, href)

import Data.News exposing (NewsId, newsidParser, nidStr)
import Navigation exposing (Location)
import UrlParser exposing (Parser, (</>), s, map, oneOf, parseHash)
import Html exposing (Html, Attribute, a, text)
import Html.Attributes as Attr


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


href : Route -> Attribute msg
href dest =
    Attr.href (routeStr dest)


routeStr : Route -> String
routeStr dest =
    let
        path =
            case dest of
                NewsFeed ->
                    []

                News nid ->
                    [ nidStr nid ]

                _ ->
                    []
    in
        "#/" ++ String.join "/" path
