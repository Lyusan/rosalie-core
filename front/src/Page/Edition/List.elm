module Page.Edition.List exposing (..)

import Util exposing ((=>))
import Data.Edition as EditionD
import View.Edition as EditionV
import Request.Edition as EditionR
import RemoteData exposing (WebData)
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { editions : WebData (List EditionD.Edition) }


init : ( Model, Cmd Msg )
init =
    Model RemoteData.Loading => listEditions


view : Model -> Html Msg
view model =
    let
        editionsView =
            case model.editions of
                RemoteData.NotAsked ->
                    text "afk"

                RemoteData.Loading ->
                    text "brb"

                RemoteData.Failure err ->
                    text (toString err)

                RemoteData.Success editions ->
                    EditionV.list editions
    in
        div [ class "editions-page" ] [ editionsView ]


listEditions : Cmd Msg
listEditions =
    EditionR.listEditions
        |> RemoteData.sendRequest
        |> Cmd.map ListEditions


type Msg
    = ListEditions (WebData (List EditionD.Edition))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ListEditions data ->
            { model | editions = data } => Cmd.none
