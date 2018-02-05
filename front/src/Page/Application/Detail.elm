module Page.Application.Detail exposing (Model, Msg, init, update, view)

import Util exposing ((=>))
import Data.Application exposing (App, AppId)
import Data.Movie exposing (Article, Interview)
import Request.Application as App
import Request.Movie as Mov
import View.Application exposing (detail)
import View.Movie exposing (articleList, interviewList)
import Html exposing (..)
import Html.Attributes exposing (class)
import RemoteData exposing (WebData)


-- MODEL --


type alias Model =
    { application : WebData App
    , articles : WebData (List Article)
    , interviews : WebData (List Interview)
    }


init : AppId -> ( Model, Cmd Msg )
init appid =
    Model RemoteData.Loading RemoteData.Loading RemoteData.Loading
        => retrieveApp appid



-- UPDATE --


type Msg
    = RetrieveApp (WebData App)
    | ListArticles (WebData (List Article))
    | ListInterviews (WebData (List Interview))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetrieveApp data ->
            let
                cmd =
                    case data of
                        RemoteData.Success app ->
                            Cmd.batch
                                [ listArticles app.movie.id
                                , listInterviews app.movie.id
                                ]

                        _ ->
                            Cmd.none
            in
                { model | application = data } => cmd

        ListArticles data ->
            { model | articles = data } => Cmd.none

        ListInterviews data ->
            { model | interviews = data } => Cmd.none



-- VIEW --


view : Model -> Html Msg
view model =
    let
        articles =
            articleList model.articles

        interviews =
            interviewList model.interviews

        views =
            [ articles, interviews ]
    in
        div [ class "application-page" ] [ detail model.application views ]



-- INTERNALS --


retrieveApp : AppId -> Cmd Msg
retrieveApp appid =
    App.retrieveApp appid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveApp


listArticles : Int -> Cmd Msg
listArticles mid =
    Mov.listArticles mid
        |> RemoteData.sendRequest
        |> Cmd.map ListArticles


listInterviews : Int -> Cmd Msg
listInterviews mid =
    Mov.listInterviews mid
        |> RemoteData.sendRequest
        |> Cmd.map ListInterviews
