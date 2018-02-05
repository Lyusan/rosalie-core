module Page.Edition.Retrieve exposing (Model, Msg, init, update, view)

import Util exposing ((=>))
import Data.Award exposing (Award)
import Data.Edition exposing (Edition, EditionId)
import Request.Edition as EditionR
import View.Edition as EditionV
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)


-- MODEL --


type alias Model =
    { edition : WebData Edition
    , awards : WebData (List Award)
    }


init : EditionId -> ( Model, Cmd Msg )
init eid =
    Model RemoteData.Loading RemoteData.Loading => retrieveEdition eid



-- UPDATE --


type Msg
    = RetrieveEditions (WebData Edition)
    | ListAwards (WebData (List Award))


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



-- VIEW --


view : Model -> Html Msg
view model =
    let
        awardsView =
            EditionV.listAwards model.awards

        editionView =
            EditionV.detail model.edition awardsView
    in
        div [ class "edition-page" ] [ editionView ]



-- INTERNALS --


retrieveEdition : EditionId -> Cmd Msg
retrieveEdition eid =
    EditionR.retrieveEdition eid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveEditions


listAwards : EditionId -> Cmd Msg
listAwards eid =
    EditionR.listEditionAwards eid
        |> RemoteData.sendRequest
        |> Cmd.map ListAwards
