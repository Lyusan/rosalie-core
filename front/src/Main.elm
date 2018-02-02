module Main exposing (..)

import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (class, src)
import Navigation exposing (Location)
import Page.Award.Retrieve as AwardR
import Page.Edition.List as EditionL
import Page.Edition.Retrieve as EditionR
import Page.News.Feed as Feed
import Page.News.Read as Read
import Page.Us exposing (us)
import Page.Wrap exposing (wrap)
import Route exposing (Route, parseLocation)
import Util exposing ((=>))


---- MODEL ----


type Page
    = NewsFeed Feed.Model
    | News Read.Model
    | Us
    | EditionList EditionL.Model
    | Edition EditionR.Model
    | Award AwardR.Model
    | NotFound


type alias Model =
    { page : Page
    , location : Location
    }


init : Location -> ( Model, Cmd Msg )
init location =
    Model (locationPage location) location => locationMsg location


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

        Route.Editions ->
            EditionList (Tuple.first EditionL.init)

        Route.Edition eid ->
            Edition (Tuple.first (EditionR.init eid))

        Route.Award aid ->
            Award (Tuple.first (AwardR.init aid))

        Route.Us ->
            Us

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

        Route.Editions ->
            Cmd.map EditionListMsg (Tuple.second EditionL.init)

        Route.Edition eid ->
            Cmd.map EditionMsg (Tuple.second (EditionR.init eid))

        Route.Award aid ->
            Cmd.map AwardMsg (Tuple.second (AwardR.init aid))

        _ ->
            Cmd.none



---- UPDATE ----


type Msg
    = LocationChange Location
    | NewsFeedMsg Feed.Msg
    | NewsMsg Read.Msg
    | EditionListMsg EditionL.Msg
    | EditionMsg EditionR.Msg
    | AwardMsg AwardR.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LocationChange location ->
            { model | page = locationPage location, location = location }
                => locationMsg location

        {--
        NewsFeedMsg subMsg ->
            updatePage model.page msg model

        NewsMsg subMsg ->
            updatePage model.page msg model

        EditionListMsg subMsg ->
            updatePage model.page msg model

        EditionMsg subMsg ->
            updatePage model.page msg model
            --}
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

        ( EditionList subModel, EditionListMsg subMsg ) ->
            toPage EditionL.update subMsg subModel EditionList EditionListMsg

        ( Edition subModel, EditionMsg subMsg ) ->
            toPage EditionR.update subMsg subModel Edition EditionMsg

        ( Award subModel, AwardMsg subMsg ) ->
            toPage AwardR.update subMsg subModel Award AwardMsg

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

        EditionList model ->
            wrap (EditionL.view model)
                |> Html.map EditionListMsg

        Edition model ->
            wrap (EditionR.view model)
                |> Html.map EditionMsg

        Award model ->
            wrap (AwardR.view model)
                |> Html.map AwardMsg

        Us ->
            wrap us

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
