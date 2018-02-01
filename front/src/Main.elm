module Main exposing (..)

import Page.Wrap exposing (wrap)
import Page.News.Feed as Feed
import Page.News.Read as Read
import Util exposing ((=>))
import Route exposing (Route, parseLocation)
import Navigation exposing (Location)
import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src, class)


---- MODEL ----


type Page
    = NewsFeed Feed.Model
    | News Read.Model
    | NotFound


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
                NotFound


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
    case msg of
        LocationChange location ->
            Model (locationPage location) => locationMsg location

        _ ->
            updatePage model.page msg model


updatePage : Page -> Msg -> Model -> ( Model, Cmd Msg )
updatePage page msg model =
    let
        toPage toUpdate subMsg subModel toModel toMsg =
            let
                ( newModel, newCmd ) =
                    toUpdate subMsg subModel
            in
                { model | page = toModel newModel } => Cmd.map toMsg newCmd
    in
        case ( page, msg ) of
            ( NewsFeed subModel, NewsFeedMsg subMsg ) ->
                toPage Feed.update subMsg subModel NewsFeed NewsFeedMsg

            ( News subModel, NewsMsg subMsg ) ->
                toPage Read.update subMsg subModel News NewsMsg

            ( _, _ ) ->
                model => Cmd.none



---- VIEW ----


view : Model -> Html Msg
view model =
    case model.page of
        NewsFeed model ->
            wrap (Feed.view model)
                |> Html.map NewsFeedMsg

        News model ->
            wrap (Read.view model)
                |> Html.map NewsMsg

        NotFound ->
            wrap (div [ class "page404" ] [ text "404 Not Found" ])



---- PROGRAM ----


main : Program Never Model Msg
main =
    Navigation.program LocationChange
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
