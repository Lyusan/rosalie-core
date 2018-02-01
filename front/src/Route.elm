module Route exposing (Route(..), parseLocation, href)

import Data.News exposing (NewsId, newsidParser, nidStr)
import Navigation exposing (Location)
import UrlParser exposing (Parser, (</>), s, map, oneOf, parseHash, top)
import Html exposing (Attribute)
import Html.Attributes as Attr


type Route
    = NewsFeed
    | News NewsId
    | NotFound


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map NewsFeed (s "")
        , map News (s "news" </> newsidParser)
        ]


parseLocation : Location -> Route
parseLocation location =
    let
        maybe =
            parseHash parser location
    in
        case maybe of
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
                    [ "news", nidStr nid ]

                _ ->
                    []
    in
        "#/" ++ String.join "/" path
