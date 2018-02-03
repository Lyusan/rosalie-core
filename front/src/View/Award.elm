module View.Award exposing (..)

import Data.Award exposing (..)
import Data.Application exposing (App, fullname)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)


winner : WebData App -> Html msg
winner data =
    let
        winnerView =
            case data of
                RemoteData.NotAsked ->
                    [ text "afk" ]

                RemoteData.Loading ->
                    [ text "brb" ]

                RemoteData.Failure err ->
                    [ text (toString err) ]

                RemoteData.Success app ->
                    let
                        movie =
                            app.movie

                        movieView =
                            div [ class "winner-movie" ]
                                [ h3 [] [ text movie.title ]
                                ]

                        person =
                            app.person

                        personView =
                            div [ class "winner-person" ]
                                [ h3 [] [ text (fullname person) ] ]
                    in
                        [ h2 [] [ text "Le gagant" ]
                        , movieView
                        , personView
                        ]
    in
        div [ class "winner-detail" ] winnerView


detail : WebData Award -> Html msg -> Html msg
detail data winnerView =
    let
        awardView =
            case data of
                RemoteData.NotAsked ->
                    [ text "afk" ]

                RemoteData.Loading ->
                    [ text "brb" ]

                RemoteData.Failure err ->
                    [ text (toString err) ]

                RemoteData.Success award ->
                    [ h1 [] [ text award.name ]
                    , p [] [ text award.desc ]
                    , h2 [] [ text "Les candidats" ]
                    , h2 [] [ text "Les nominés" ]
                    , winnerView
                    , button [] [ text "FixMe" ]
                    ]
    in
        div [ class "award-detail" ]
            awardView
