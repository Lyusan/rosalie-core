module Page.Edition.List exposing (Model, Msg, init, update, view)

import Util exposing ((=>))
import Data.Edition exposing (Edition)
import View.Edition as EditionV
import Request.Edition as EditionR
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)


-- MODEL --


type alias Model =
    { editions : WebData (List Edition) }


init : ( Model, Cmd Msg )
init =
    Model RemoteData.Loading => listEditions



-- VIEW --


view : Model -> Html Msg
view model =
    div [ class "editions-page" ] [ (EditionV.list model.editions) ]



-- UPDATE --


type Msg
    = ListEditions (WebData (List Edition))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ListEditions data ->
            { model | editions = data } => Cmd.none



-- INTERNALS --


listEditions : Cmd Msg
listEditions =
    EditionR.listEditions
        |> RemoteData.sendRequest
        |> Cmd.map ListEditions
