module Page.News.Feed exposing (..)

import Util exposing ((=>))
import Data.News as NewsD
import Request.News as NewsR
import View.News as NewV
import RemoteData exposing (WebData)
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { feed : WebData (List NewsD.News) }


init : ( Model, Cmd Msg )
init =
    Model RemoteData.Loading => listNews


view : Model -> Html Msg
view model =
    let
        feedView =
            NewV.list model.feed
    in
        div [ class "feed-page" ] [ feedView ]


listNews : Cmd Msg
listNews =
    NewsR.listNews
        |> RemoteData.sendRequest
        |> Cmd.map ListNews


type Msg
    = ListNews (WebData (List NewsD.News))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ListNews data ->
            { model | feed = data } => Cmd.none
