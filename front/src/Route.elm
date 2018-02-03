module Route exposing (Route(..), href, parseLocation)

import Data.Award exposing (AwardId, aidParser, aidStr)
import Data.Edition exposing (EditionId, eidParser, eidStr)
import Data.News exposing (NewsId, newsidParser, nidStr)
import Data.Application exposing (AppId, appidParser, appidStr)
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
    | Candidates AwardId
    | Nominees AwardId
    | Application AppId
    | Winners
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
        , map Candidates (s "candidates" </> aidParser)
        , map Nominees (s "nominees" </> aidParser)
        , map Application (s "application" </> appidParser)
        , map Winners (s "winners")
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

                Candidates aid ->
                    [ "candidates", aidStr aid ]

                Nominees aid ->
                    [ "nominees", aidStr aid ]

                Application appid ->
                    [ "application", appidStr appid ]

                Winners ->
                    [ "winners" ]

                NotFound ->
                    []
    in
        "#/" ++ String.join "/" path
