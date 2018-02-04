module Page.Movie.Interview exposing (..)

import RemoteData exposing (WebData)
import Html exposing (..)
import Html.Attributes exposing (..)
import Data.Movie exposing (Interview)
import Request.Movie as Req
import View.Movie exposing (interviewDetail)
import Util exposing ((=>))


type alias Model =
    { interview : WebData Interview }


init : Int -> ( Model, Cmd Msg )
init aid =
    Model RemoteData.Loading => retrieveInterview aid


view : Model -> Html Msg
view model =
    div [ class "page-interview" ] [ interviewDetail model.interview ]


retrieveInterview : Int -> Cmd Msg
retrieveInterview aid =
    Req.retrieveInterview aid
        |> RemoteData.sendRequest
        |> Cmd.map RetrieveInterview


type Msg
    = RetrieveInterview (WebData Interview)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RetrieveInterview data ->
            { model | interview = data } => Cmd.none
