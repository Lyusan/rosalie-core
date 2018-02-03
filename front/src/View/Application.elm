module View.Application exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Data.Application exposing (..)


detail : WebData App -> Html msg
detail data =
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
        div [ class "application-detail" ] view


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
        [ text (app.movie.title ++ " - " ++ (fullname app.person))
        ]
