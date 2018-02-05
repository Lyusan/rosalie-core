module Page.Application.Award exposing (Model, Msg, init, update, view)

import Util exposing ((=>))
import Data.Award exposing (AwardId)
import Data.Application exposing (App)
import Request.Award as AwardR
import View.Application as AppV
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)


-- MODEL --


type alias Model =
    { applications : WebData (List App)
    , nominees : Bool
    }


init : AwardId -> Bool -> ( Model, Cmd Msg )
init aid bool =
    Model RemoteData.Loading bool => listApplications aid bool



-- UPDATE --


type Msg
    = ListApplications (WebData (List App))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ListApplications data ->
            { model | applications = data } => Cmd.none



-- VIEW --


view : Model -> Html Msg
view model =
    let
        page =
            if model.nominees then
                "nominees"
            else
                "candidates"
    in
        div [ class ("page-" ++ page) ] [ AppV.list model.applications ]



-- INTERNALS --


listApplications : AwardId -> Bool -> Cmd Msg
listApplications aid bool =
    AwardR.listApplications aid bool
        |> RemoteData.sendRequest
        |> Cmd.map ListApplications
