module Page.News.Read exposing (..)

import RemoteData exposing (WebData)
import Util exposing ((=>))
import Data.News as NewsD
import View.News as NewsV
import Request.News as NewsR
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { news : WebData NewsD.News }


init : NewsD.NewsId -> ( Model, Cmd Msg )
init nid =
    Model RemoteData.Loading => retrieveNews nid


view : Model -> Html Msg
view model =
    let
        newsView =
            NewsV.detail model.news
    in
        div [ class "news-page" ] [ newsView ]


retrieveNews : NewsD.NewsId -> Cmd Msg
retrieveNews nid =
    NewsR.retrieveNews nid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveNews


type Msg
    = RetrieveNews (WebData NewsD.News)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetrieveNews data ->
            Model data => Cmd.none
