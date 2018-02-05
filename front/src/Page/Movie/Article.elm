module Page.Movie.Article exposing (Model, Msg, init, update, view)

import Util exposing ((=>))
import Data.Movie exposing (Article)
import Request.Movie as Req
import View.Movie exposing (articleDetail)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)


-- MODEL --


type alias Model =
    { article : WebData Article }


init : Int -> ( Model, Cmd Msg )
init aid =
    Model RemoteData.Loading => retrieveArticle aid



-- UPDATE --


type Msg
    = RetrieveArticle (WebData Article)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetrieveArticle data ->
            { model | article = data } => Cmd.none



-- VIEW --


view : Model -> Html Msg
view model =
    div [ class "page-article" ] [ articleDetail model.article ]



-- INTERNALS --


retrieveArticle : Int -> Cmd Msg
retrieveArticle aid =
    Req.retrieveArticle aid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveArticle
