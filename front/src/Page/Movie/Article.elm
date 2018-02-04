module Page.Movie.Article exposing (..)

import RemoteData exposing (WebData)
import Html exposing (..)
import Html.Attributes exposing (..)
import Data.Movie exposing (Article)
import Request.Movie as Req
import View.Movie exposing (articleDetail)
import Util exposing ((=>))


type alias Model =
    { article : WebData Article }


init : Int -> ( Model, Cmd Msg )
init aid =
    Model RemoteData.Loading => retrieveArticle aid


view : Model -> Html Msg
view model =
    div [ class "page-article" ] [ articleDetail model.article ]


retrieveArticle : Int -> Cmd Msg
retrieveArticle aid =
    Req.retrieveArticle aid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveArticle


type Msg
    = RetrieveArticle (WebData Article)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetrieveArticle data ->
            { model | article = data } => Cmd.none
