module Page.Award.Retrieve exposing (Model, Msg, init, update, view)

import Util exposing ((=>))
import Data.Award exposing (Award, AwardId)
import Data.Application exposing (App)
import Request.Award as AwardR
import View.Award exposing (detail, winner)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)


-- MODEL --


type alias Model =
    { award : WebData Award
    , winner : WebData App
    }


init : AwardId -> ( Model, Cmd Msg )
init aid =
    Model RemoteData.Loading RemoteData.Loading => retrieveAward aid



-- UPDATE --


type Msg
    = RetrieveAward (WebData Award)
    | RetrieveWinner (WebData App)


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



-- VIEW --


view : Model -> Html Msg
view model =
    let
        winnerView =
            winner model.winner
    in
        div [ class "award-page" ] [ (detail model.award winnerView) ]



-- INTERNALS --


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
