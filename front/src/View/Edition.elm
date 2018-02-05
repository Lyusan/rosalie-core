module View.Edition exposing (detail, list, listAwards)

import Data.Award exposing (Award)
import Data.Edition exposing (Edition)
import View.Util exposing (dataview)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Route


detail : WebData Edition -> Html msg -> Html msg
detail data awardsView =
    let
        view =
            case data of
                RemoteData.Success edition ->
                    [ h1 [] [ text edition.name ]
                    , awardsView
                    , button [] [ text "FixMe" ]
                    ]

                _ ->
                    dataview data
    in
        div [ class "edition-detail" ] view


list : WebData (List Edition) -> Html msg
list data =
    let
        view =
            case data of
                RemoteData.Success editions ->
                    (List.map row editions)

                _ ->
                    dataview data
    in
        div [ class "edition-list" ] view


listAwards : WebData (List Award) -> Html msg
listAwards data =
    let
        view =
            case data of
                RemoteData.Success awards ->
                    (List.map rowAward awards)

                _ ->
                    dataview data
    in
        div [ class "edition-awards" ] view


row : Edition -> Html msg
row edition =
    div [ class "edition-row" ]
        [ a [ Route.href (Route.Edition edition.id) ]
            [ text edition.name ]
        ]


rowAward : Award -> Html msg
rowAward award =
    div [ class "award-row" ]
        [ a [ Route.href (Route.Award award.id) ]
            [ text award.name ]
        ]
