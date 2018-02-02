module Page.Edition.Retrieve exposing (..)

import Data.Award as AwarD
import Data.Edition as EditionD
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Request.Edition as EditionR
import Util exposing ((=>))
import View.Edition as EditionV


type alias Model =
    { edition : WebData EditionD.Edition
    , awards : WebData (List AwarD.Award)
    }


init : EditionD.EditionId -> ( Model, Cmd Msg )
init eid =
    Model RemoteData.Loading RemoteData.Loading => retrieveEdition eid


view : Model -> Html Msg
view model =
    let
        awardsView =
            case model.awards of
                RemoteData.NotAsked ->
                    text "afk"

                RemoteData.Loading ->
                    text "brb"

                RemoteData.Failure err ->
                    text (toString err)

                RemoteData.Success awards ->
                    EditionV.listAwards awards

        editionView =
            case model.edition of
                RemoteData.NotAsked ->
                    text "afk"

                RemoteData.Loading ->
                    text "brb"

                RemoteData.Failure err ->
                    text (toString err)

                RemoteData.Success edition ->
                    EditionV.detail edition awardsView
    in
    div [ class "edition-page" ] [ editionView ]


retrieveEdition : EditionD.EditionId -> Cmd Msg
retrieveEdition eid =
    EditionR.retrieveEdition eid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveEditions


listAwards : EditionD.EditionId -> Cmd Msg
listAwards eid =
    EditionR.listEditionAwards eid
        |> RemoteData.sendRequest
        |> Cmd.map ListAwards


type Msg
    = RetrieveEditions (WebData EditionD.Edition)
    | ListAwards (WebData (List AwarD.Award))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetrieveEditions data ->
            let
                cmd =
                    case data of
                        RemoteData.Success edition ->
                            listAwards edition.id

                        _ ->
                            Cmd.none
            in
            { model | edition = data } => cmd

        ListAwards data ->
            { model | awards = data } => Cmd.none
