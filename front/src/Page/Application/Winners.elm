module Page.Application.Winners exposing (..)

import Util exposing ((=>))
import Request.Application as App
import View.Application exposing (..)
import Data.Application exposing (..)
import RemoteData exposing (WebData)
import Html exposing (..)
import Html.Attributes exposing (class)


type alias Model =
    { winners : WebData (List App) }


init : ( Model, Cmd Msg )
init =
    Model RemoteData.Loading => listWinners


view : Model -> Html Msg
view model =
    div [ class "winners-page" ]
        [ h1 [] [ text "Winners" ]
        , list model.winners
        ]


listWinners : Cmd Msg
listWinners =
    App.listWinners
        |> RemoteData.sendRequest
        |> Cmd.map ListWinners


type Msg
    = ListWinners (WebData (List App))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ListWinners data ->
            { model | winners = data } => Cmd.none
