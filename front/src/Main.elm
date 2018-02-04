module Main exposing (..)

import Page.Application.Award as AppA
import Page.Application.Detail as AppD
import Page.Application.Winners as AppW
import Page.Movie.Article as MovA
import Page.Movie.Interview as MovI
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
    | AwardApps AppA.Model
    | App AppD.Model
    | Winners AppW.Model
    | Article MovA.Model
    | Interview MovI.Model
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

            Route.Candidates aid ->
                AwardApps (Tuple.first (AppA.init aid False))

            Route.Nominees aid ->
                AwardApps (Tuple.first (AppA.init aid True))

            Route.Application appid ->
                App (Tuple.first (AppD.init appid))

            Route.Winners ->
                Winners (Tuple.first (AppW.init))

            Route.Article i ->
                Article (Tuple.first (MovA.init i))

            Route.Interview i ->
                Interview (Tuple.first (MovI.init i))

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

            Route.Candidates aid ->
                Cmd.map AwardAppsMsg (Tuple.second (AppA.init aid False))

            Route.Nominees aid ->
                Cmd.map AwardAppsMsg (Tuple.second (AppA.init aid True))

            Route.Application appid ->
                Cmd.map AppMsg (Tuple.second (AppD.init appid))

            Route.Winners ->
                Cmd.map WinnersMsg (Tuple.second (AppW.init))

            Route.Article i ->
                Cmd.map ArticleMsg (Tuple.second (MovA.init i))

            Route.Interview i ->
                Cmd.map InterviewMsg (Tuple.second (MovI.init i))

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
    | AwardAppsMsg AppA.Msg
    | AppMsg AppD.Msg
    | WinnersMsg AppW.Msg
    | ArticleMsg MovA.Msg
    | InterviewMsg MovI.Msg


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

            ( AwardApps subModel, AwardAppsMsg subMsg ) ->
                toPage AppA.update subMsg subModel AwardApps AwardAppsMsg

            ( App subModel, AppMsg subMsg ) ->
                toPage AppD.update subMsg subModel App AppMsg

            ( Winners subModel, WinnersMsg subMsg ) ->
                toPage AppW.update subMsg subModel Winners WinnersMsg

            ( Article subModel, ArticleMsg subMsg ) ->
                toPage MovA.update subMsg subModel Article ArticleMsg

            ( Interview subModel, InterviewMsg subMsg ) ->
                toPage MovI.update subMsg subModel Interview InterviewMsg

            ( _, _ ) ->
                model => Cmd.none



---- VIEW ----


view : Model -> Html Msg
view model =
    let
        toWrap toView model toMsg =
            wrap (toView model)
                |> Html.map toMsg
    in
        case model.page of
            NewsFeed model ->
                toWrap Feed.view model NewsFeedMsg

            News model ->
                toWrap Read.view model NewsMsg

            EditionList model ->
                toWrap EditionL.view model EditionListMsg

            Edition model ->
                toWrap EditionR.view model EditionMsg

            Award model ->
                toWrap AwardR.view model AwardMsg

            AwardApps model ->
                toWrap AppA.view model AwardAppsMsg

            App model ->
                toWrap AppD.view model AppMsg

            Winners model ->
                toWrap AppW.view model WinnersMsg

            Article model ->
                toWrap MovA.view model ArticleMsg

            Interview model ->
                toWrap MovI.view model InterviewMsg

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
