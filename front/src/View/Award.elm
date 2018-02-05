module View.Award exposing (detail, winner)

import Data.Award exposing (Award)
import Data.Application exposing (App, Movie, Person, fullname)
import View.Util exposing (dataview)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Route


detail : WebData Award -> Html msg -> Html msg
detail data awardWinner =
    div [ class "award-detail" ] (dataview data (awardDetail awardWinner))


winner : WebData App -> Html msg
winner data =
    div [ class "winner-detail" ] (dataview data winnerView)



-- INTERNALS --


awardDetail : Html msg -> Award -> List (Html msg)
awardDetail winnerView award =
    [ h1 [] [ text award.name ]
    , p [] [ text award.desc ]
    , a [ Route.href (Route.Candidates award.id) ]
        [ h2 [] [ text "Les candidats" ] ]
    , a [ Route.href (Route.Nominees award.id) ]
        [ h2 [] [ text "Les nominés" ] ]
    , winnerView
    , button [] [ text "FixMe" ]
    ]


winnerView : App -> List (Html msg)
winnerView app =
    [ a [ Route.href (Route.Application app.id) ]
        [ h2 [] [ text "Le gagant" ] ]
    , movieView app.movie
    , personView app.person
    ]


movieView : Movie -> Html msg
movieView movie =
    div [ class "winner-movie" ]
        [ h3 [] [ text movie.title ]
        ]


personView : Person -> Html msg
personView person =
    div [ class "winner-person" ]
        [ h3 [] [ text (fullname person) ] ]
