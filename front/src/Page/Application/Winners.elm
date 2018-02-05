module Page.Application.Winners exposing (Model, Msg, init, update, view)

import Util exposing ((=>))
import Data.Application exposing (App)
import Request.Application as App
import View.Application exposing (list)
import Html exposing (..)
import Html.Attributes exposing (class)
import RemoteData exposing (WebData)


-- MODEL --


type alias Model =
    { winners : WebData (List App) }


init : ( Model, Cmd Msg )
init =
    Model RemoteData.Loading => listWinners



-- UPDATE --


type Msg
    = ListWinners (WebData (List App))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ListWinners data ->
            { model | winners = data } => Cmd.none



-- VIEW --


view : Model -> Html Msg
view model =
    div [ class "winners-page" ]
        [ (list model.winners) ]



-- INTERNALS --


listWinners : Cmd Msg
listWinners =
    App.listWinners
        |> RemoteData.sendRequest
        |> Cmd.map ListWinners
