module Page.Application.Award exposing (..)

import Util exposing ((=>))
import RemoteData exposing (WebData)
import Data.Award exposing (AwardId)
import Data.Application exposing (App)
import Request.Award as AwardR
import Html exposing (..)
import View.Application exposing (..)


type alias Model =
    { applications : WebData (List App)
    }


init : AwardId -> Bool -> ( Model, Cmd Msg )
init aid bool =
    Model RemoteData.Loading => listApplications aid bool


view : Model -> Html Msg
view model =
    div [] [ list model.applications ]


listApplications : AwardId -> Bool -> Cmd Msg
listApplications aid bool =
    AwardR.listApplications aid bool
        |> RemoteData.sendRequest
        |> Cmd.map ListApplications


type Msg
    = ListApplications (WebData (List App))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ListApplications data ->
            { model | applications = data } => Cmd.none
