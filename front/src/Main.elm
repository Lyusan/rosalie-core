module Main exposing (..)

import Route exposing (parseLocation)
import Navigation exposing (Location)
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)


---- MODEL ----


type Page
    = NewsFeed
    | News


type alias Model =
    { page : Page
    }


init : Location -> ( Model, Cmd Msg )
init location =
    ( Model (locationPage location), Cmd.none )


locationPage : Location -> Page
locationPage location =
    case (parseLocation location) of
        Route.NewsFeed ->
            NewsFeed

        Route.News ->
            News

        Route.NotFound ->
            NewsFeed



---- UPDATE ----


type Msg
    = LocationChange Location


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
