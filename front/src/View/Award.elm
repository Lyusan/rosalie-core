module View.Award exposing (detail, winner)

import Data.Award exposing (Award)
import Data.Application exposing (App, Movie, Person, fullname)
import View.Util exposing (dataview)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Route


detail : WebData Award -> Html msg -> Html msg
detail data winnerView =
    let
        awardView =
            case data of
                RemoteData.Success award ->
                    [ h1 [] [ text award.name ]
                    , p [] [ text award.desc ]
                    , a [ Route.href (Route.Candidates award.id) ]
                        [ h2 [] [ text "Les candidats" ] ]
                    , a [ Route.href (Route.Nominees award.id) ]
                        [ h2 [] [ text "Les nominés" ] ]
                    , winnerView
                    , button [] [ text "FixMe" ]
                    ]

                _ ->
                    dataview data
    in
        div [ class "award-detail" ]
            awardView


winner : WebData App -> Html msg
winner data =
    let
        winnerView =
            case data of
                RemoteData.Success app ->
                    [ a [ Route.href (Route.Application app.id) ]
                        [ h2 [] [ text "Le gagant" ] ]
                    , movieView app.movie
                    , personView app.person
                    ]

                _ ->
                    dataview data
    in
        div [ class "winner-detail" ] winnerView


movieView : Movie -> Html msg
movieView movie =
    div [ class "winner-movie" ]
        [ h3 [] [ text movie.title ]
        ]


personView : Person -> Html msg
personView person =
    div [ class "winner-person" ]
        [ h3 [] [ text (fullname person) ] ]
