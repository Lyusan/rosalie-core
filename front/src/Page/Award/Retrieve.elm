module Page.Award.Retrieve exposing (..)

import Data.Award exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Request.Award as AwardR
import Util exposing ((=>))
import View.Award exposing (..)


type alias Model =
    { award : WebData Award
    , winner : String
    }


init : AwardId -> ( Model, Cmd Msg )
init aid =
    Model RemoteData.Loading "" => retrieveAward aid


view : Model -> Html Msg
view model =
    let
        awardView =
            case model.award of
                RemoteData.NotAsked ->
                    text "afk"

                RemoteData.Loading ->
                    text "brb"

                RemoteData.Failure err ->
                    text (toString err)

                RemoteData.Success award ->
                    detail award
    in
    div [ class "award-page" ] [ awardView ]


retrieveAward : AwardId -> Cmd Msg
retrieveAward aid =
    AwardR.retrieveAward aid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveAward


type Msg
    = RetrieveAward (WebData Award)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetrieveAward data ->
            { model | award = data } => Cmd.none
