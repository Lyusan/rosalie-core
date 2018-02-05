module View.Util exposing (dataview)

import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)


dataview : WebData a -> (a -> List (Html msg)) -> List (Html msg)
dataview data success =
    case data of
        RemoteData.NotAsked ->
            [ text "afk" ]

        RemoteData.Loading ->
            [ text "brb" ]

        RemoteData.Failure err ->
            [ text (toString err) ]

        RemoteData.Success a ->
            success a
