module Main exposing (..)

import Page.News.Feed as Feed
import Page.News.Read as Read
import Util exposing ((=>))
import Route exposing (parseLocation)
import Navigation exposing (Location)
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)


---- MODEL ----


type Page
    = NewsFeed Feed.Model
    | News Read.Model


type alias Model =
    { page : Page
    }


init : Location -> ( Model, Cmd Msg )
init location =
    Model (locationPage location) => (locationMsg location)


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
                News (Tuple.first (Read.init nid))

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

            Route.News nid ->
                Cmd.map NewsMsg (Tuple.second (Read.init nid))

            _ ->
                Cmd.none



---- UPDATE ----


type Msg
    = LocationChange Location
    | NewsFeedMsg Feed.Msg
    | NewsMsg Read.Msg


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
