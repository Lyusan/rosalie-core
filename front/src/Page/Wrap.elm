module Page.Wrap exposing (wrap)

import Route exposing (Route)
import Html exposing (..)
import Html.Attributes exposing (..)


wrap : Html msg -> Html msg
wrap content =
    div [ class "page-wrap" ]
        [ viewHeader
        , hr [] []
        , content
        , hr [] []
        , viewFooter
        ]



-- INTERNALS --


viewHeader : Html msg
viewHeader =
    header [ class "header" ]
        [ text "Header"
        , nav [ class "navbar" ] navRefs
        ]


viewFooter : Html msg
viewFooter =
    footer [ class "footer" ] [ text "Footer" ]


navRefs : List (Html msg)
navRefs =
    List.map hrefLink navLinks


navLinks : List Link
navLinks =
    [ Link Route.NewsFeed "Actualités"
    , Link Route.Us "Qui sommes-nous ?"
    , Link Route.Editions "Nos Éditions"
    , Link Route.Winners "Les récompensés"
    ]


type alias Link =
    { dest : Route, label : String }


hrefLink : Link -> Html msg
hrefLink link =
    div [ class "navdiv" ]
        [ a [ class "navref", Route.href link.dest ]
            [ text link.label ]
        ]
