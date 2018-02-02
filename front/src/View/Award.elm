module View.Award exposing (..)

import Data.Award exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


detail : Award -> Html msg
detail award =
    div [ class "award-detail" ]
        [ h1 [] [ text award.name ]
        , p [] [ text award.desc ]
        , h2 [] [ text "Les candidats" ]
        , h2 [] [ text "Les nominés" ]
        , h2 [] [ text "Récompensé" ]
        , button [] [ text "FixMe" ]
        ]
