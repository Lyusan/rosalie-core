module Page.Application.Detail exposing (..)

import Util exposing ((=>))
import Data.Application exposing (..)
import RemoteData exposing (WebData)
import Request.Application as App
import Html exposing (..)
import View.Application exposing (..)
import Html.Attributes exposing (class)


type alias Model =
    { application : WebData App }


init : AppId -> ( Model, Cmd Msg )
init appid =
    Model RemoteData.Loading => retrieveApp appid


view : Model -> Html Msg
view model =
    div [ class "application-page" ]
        [ detail model.application ]


retrieveApp : AppId -> Cmd Msg
retrieveApp appid =
    App.retrieveApp appid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveApp


type Msg
    = RetrieveApp (WebData App)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetrieveApp data ->
            { model | application = data } => Cmd.none
