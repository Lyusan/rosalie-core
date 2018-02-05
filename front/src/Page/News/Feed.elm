module Page.News.Feed exposing (Model, Msg, init, view, update)

import Util exposing ((=>))
import Data.News exposing (News)
import Request.News as NewsR
import View.News as NewsV
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)


-- MODEL --


type alias Model =
    { feed : WebData (List News) }


init : ( Model, Cmd Msg )
init =
    Model RemoteData.Loading => listNews



-- UPDATE --


type Msg
    = ListNews (WebData (List News))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ListNews data ->
            { model | feed = data } => Cmd.none



-- VIEW --


view : Model -> Html Msg
view model =
    div [ class "feed-page" ] [ (NewsV.list model.feed) ]



-- INTERNALS --


listNews : Cmd Msg
listNews =
    NewsR.listNews
        |> RemoteData.sendRequest
        |> Cmd.map ListNews
