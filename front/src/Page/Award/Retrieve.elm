module Page.Award.Retrieve exposing (..)

import Data.Award exposing (..)
import Data.Application as App
import Html exposing (..)
import RemoteData exposing (WebData)
import Request.Award as AwardR
import Util exposing ((=>))
import View.Award exposing (..)


type alias Model =
    { award : WebData Award
    , winner : WebData App.App
    }


init : AwardId -> ( Model, Cmd Msg )
init aid =
    Model RemoteData.Loading RemoteData.Loading => retrieveAward aid


view : Model -> Html Msg
view model =
    let
        winnerView =
            winner model.winner
    in
        detail model.award winnerView


retrieveAward : AwardId -> Cmd Msg
retrieveAward aid =
    AwardR.retrieveAward aid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveAward


retrieveWinner : AwardId -> Cmd Msg
retrieveWinner aid =
    AwardR.retrieveWinner aid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveWinner


type Msg
    = RetrieveAward (WebData Award)
    | RetrieveWinner (WebData App.App)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetrieveAward data ->
            let
                cmd =
                    case data of
                        RemoteData.Success award ->
                            retrieveWinner award.id

                        _ ->
                            Cmd.none
            in
                { model | award = data } => cmd

        RetrieveWinner data ->
            { model | winner = data } => Cmd.none
