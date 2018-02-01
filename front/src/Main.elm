module Main exposing (..)

import Page.News.Feed as Feed
import Data.News exposing (NewsId)
import Util exposing ((=>))
import Route exposing (parseLocation)
import Navigation exposing (Location)
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)


---- MODEL ----


type Page
    = NewsFeed Feed.Model
    | News NewsId


type alias Model =
    { page : Page
    }


init : Location -> ( Model, Cmd Msg )
init location =
    Model (locationPage location) => Cmd.none


locationPage : Location -> Page
locationPage location =
    let
        route =
            parseLocation location
    in
        case route of
            Route.NewsFeed ->
                NewsFeed (Tuple.first Feed.init)

            Route.News nid ->
                News nid

            Route.NotFound ->
                NewsFeed (Tuple.first Feed.init)


locationMsg : Location -> Cmd Msg
locationMsg location =
    let
        route =
            parseLocation location
    in
        case route of
            Route.NewsFeed ->
                Cmd.map NewsFeedMsg (Tuple.second Feed.init)

            _ ->
                Cmd.none



---- UPDATE ----


type Msg
    = LocationChange Location
    | NewsFeedMsg Feed.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "Your Elm App is working!" ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program LocationChange
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
