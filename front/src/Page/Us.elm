module Page.Us exposing (us)

import Html exposing (..)
import Html.Attributes exposing (..)


us : Html msg
us =
    div [ class "page-us" ]
        [ h1 [] [ text "Qui sommes-nous ?" ]
        , h2 [] [ text "Les membres" ]
        , p [] [ text "Pif, Paf et Pouf." ]
        , h2 [] [ text "Rosalie" ]
        , p [] [ text "Rosalie, Rosalie everywhere" ]
        ]
