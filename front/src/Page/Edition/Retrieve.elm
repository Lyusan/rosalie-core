module Page.Edition.Retrieve exposing (..)

import Util exposing ((=>))
import Data.Edition as EditionD
import View.Edition as EditionV
import Request.Edition as EditionR
import RemoteData exposing (WebData)
import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { edition : WebData EditionD.Edition }


init : EditionD.EditionId -> ( Model, Cmd Msg )
init eid =
    Model RemoteData.Loading => retrieveEdition eid


view : Model -> Html Msg
view model =
    let
        editionView =
            case model.edition of
                RemoteData.NotAsked ->
                    text "afk"

                RemoteData.Loading ->
                    text "brb"

                RemoteData.Failure err ->
                    text (toString err)

                RemoteData.Success edition ->
                    EditionV.detail edition
    in
        div [ class "edition-page" ] [ editionView ]


retrieveEdition : EditionD.EditionId -> Cmd Msg
retrieveEdition eid =
    EditionR.retrieveEdition eid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveEditions


type Msg
    = RetrieveEditions (WebData EditionD.Edition)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetrieveEditions data ->
            { model | edition = data } => Cmd.none
