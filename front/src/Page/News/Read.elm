module Page.News.Read exposing (Model, Msg, init, update, view)

import Util exposing ((=>))
import Data.News exposing (News, NewsId)
import View.News as NewsV
import Request.News as NewsR
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)


-- MODEL --


type alias Model =
    { news : WebData News }


init : NewsId -> ( Model, Cmd Msg )
init nid =
    Model RemoteData.Loading => retrieveNews nid



-- UPDATE --


type Msg
    = RetrieveNews (WebData News)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetrieveNews data ->
            Model data => Cmd.none



-- VIEW --


view : Model -> Html Msg
view model =
    div [ class "news-page" ] [ (NewsV.detail model.news) ]



-- INTERNALS --


retrieveNews : NewsId -> Cmd Msg
retrieveNews nid =
    NewsR.retrieveNews nid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveNews
