module View.Application exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Data.Application exposing (..)
import Route


detail : WebData App -> List (Html msg) -> Html msg
detail data views =
    let
        view =
            case data of
                RemoteData.NotAsked ->
                    [ text "afk" ]

                RemoteData.Loading ->
                    [ text "brb" ]

                RemoteData.Failure err ->
                    [ text (toString err) ]

                RemoteData.Success app ->
                    [ h1 []
                        [ text (app.movie.title ++ " - " ++ (fullname app.person)) ]
                    , h2 [] [ text app.movie.title ]
                    , p [] [ text app.movie.desc ]
                    , h2 [] [ text (fullname app.person) ]
                    , p [] [ text app.person.desc ]
                    ]
    in
        div [ class "application-detail" ] (view ++ views)


list : WebData (List App) -> Html msg
list data =
    let
        listView =
            case data of
                RemoteData.NotAsked ->
                    [ text "afk" ]

                RemoteData.Loading ->
                    [ text "brb" ]

                RemoteData.Failure err ->
                    [ text (toString err) ]

                RemoteData.Success apps ->
                    List.map row apps
    in
        div [ class "application-list" ]
            listView


row : App -> Html msg
row app =
    div [ class "application-row" ]
        [ a [ Route.href (Route.Application app.id) ]
            [ text (app.movie.title ++ " - " ++ (fullname app.person)) ]
        ]
