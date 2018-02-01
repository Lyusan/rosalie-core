module View.Edition exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Data.Edition exposing (..)
import Route


detail : Edition -> Html msg
detail edition =
    div [ class "edition-detail" ]
        [ h1 [] [ text edition.name ]
        , h2 [] [ text "Les candidats" ]
        , h2 [] [ text "Les nominés" ]
        , h2 [] [ text "Récompensé" ]
        , button [] [ text "FixMe" ]
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
