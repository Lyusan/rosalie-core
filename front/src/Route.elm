module Route exposing (Route(..), href, parseLocation)

import Data.Award exposing (AwardId, aidParser, aidStr)
import Data.Edition exposing (EditionId, eidParser, eidStr)
import Data.News exposing (NewsId, newsidParser, nidStr)
import Html exposing (Attribute)
import Html.Attributes as Attr
import Navigation exposing (Location)
import UrlParser exposing ((</>), Parser, map, oneOf, parseHash, s, top)


type Route
    = NewsFeed
    | News NewsId
    | Editions
    | Edition EditionId
    | Award AwardId
    | Us
    | NotFound


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map NewsFeed top
        , map NewsFeed (s "")
        , map News (s "news" </> newsidParser)
        , map Us (s "us")
        , map Editions (s "editions")
        , map Edition (s "editions" </> eidParser)
        , map Award (s "awards" </> aidParser)
        ]


parseLocation : Location -> Route
parseLocation location =
    case parseHash parser location of
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

                Us ->
                    [ "us" ]

                Editions ->
                    [ "editions" ]

                Edition eid ->
                    [ "editions", eidStr eid ]

                Award aid ->
                    [ "awards", aidStr aid ]

                NotFound ->
                    []
    in
    "#/" ++ String.join "/" path
