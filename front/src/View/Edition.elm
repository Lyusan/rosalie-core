module View.Edition exposing (..)

import Data.Award exposing (Award)
import Data.Edition exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Route


detail : Edition -> Html msg -> Html msg
detail edition awardsView =
    div [ class "edition-detail" ]
        [ h1 [] [ text edition.name ]
        , awardsView
        , button [] [ text "FixMe" ]
        ]


listAwards : List Award -> Html msg
listAwards awards =
    div [ class "edition-awards" ]
        (List.map rowAward awards)


rowAward : Award -> Html msg
rowAward award =
    div [ class "award-row" ]
        [ a [ Route.href (Route.Award award.id) ]
            [ text award.name ]
        ]


list : List Edition -> Html msg
list editions =
    div [ class "edition-list" ]
        (List.map row editions)


row : Edition -> Html msg
row edition =
    div [ class "edition-row" ]
        [ a [ Route.href (Route.Edition edition.id) ]
            [ text edition.name ]
        ]
