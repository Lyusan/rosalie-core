module Page.Wrap exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Route exposing (Route, href)


wrap : Html msg -> Html msg
wrap content =
    div [ class "page-wrap" ]
        [ viewHeader
        , content
        , viewFooter
        ]


viewHeader : Html msg
viewHeader =
    header [ class "header" ]
        [ text "Header"
        , nav [ class "navbar" ] navRefs
        ]


navRefs : List (Html msg)
navRefs =
    List.map hrefLink navLinks


type alias Link =
    { dest : Route, label : String }


hrefLink : Link -> Html msg
hrefLink link =
    a [ Route.href link.dest ] [ text link.label ]


navLinks : List Link
navLinks =
    [ Link Route.NewsFeed "Actualités" ]


viewFooter : Html msg
viewFooter =
    footer [ class "footer" ] [ text "Footer" ]
