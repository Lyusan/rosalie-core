module View.Edition exposing (detail, list, listAwards)

import Data.Award exposing (Award)
import Data.Edition exposing (Edition)
import View.Util exposing (dataview)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Route


detail : WebData Edition -> Html msg -> Html msg
detail data editionAwards =
    div [ class "edition-detail" ] (dataview data (editionDetail editionAwards))


list : WebData (List Edition) -> Html msg
list data =
    div [ class "edition-list" ] (dataview data editionList)


listAwards : WebData (List Award) -> Html msg
listAwards data =
    div [ class "edition-awards" ] (dataview data awardList)



-- INTERNALS --


editionDetail : Html msg -> Edition -> List (Html msg)
editionDetail editionAwards edition =
    [ h1 [] [ text edition.name ]
    , editionAwards
    , button [] [ text "FixMe" ]
    ]


editionList : List Edition -> List (Html msg)
editionList editions =
    List.map editionRow editions


editionRow : Edition -> Html msg
editionRow edition =
    div [ class "edition-row" ]
        [ a [ Route.href (Route.Edition edition.id) ]
            [ text edition.name ]
        ]


awardList : List Award -> List (Html msg)
awardList awards =
    List.map awardRow awards


awardRow : Award -> Html msg
awardRow award =
    div [ class "award-row" ]
        [ a [ Route.href (Route.Award award.id) ]
            [ text award.name ]
        ]
