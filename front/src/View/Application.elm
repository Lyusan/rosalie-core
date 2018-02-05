module View.Application exposing (detail, list)

import Data.Application exposing (App, fullname)
import View.Util exposing (dataview)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Route


detail : WebData App -> List (Html msg) -> Html msg
detail data views =
    let
        view =
            case data of
                RemoteData.Success app ->
                    [ h1 []
                        [ text (app.movie.title ++ " - " ++ (fullname app.person)) ]
                    , h2 [] [ text app.movie.title ]
                    , p [] [ text app.movie.desc ]
                    , h2 [] [ text (fullname app.person) ]
                    , p [] [ text app.person.desc ]
                    ]

                _ ->
                    dataview data
    in
        div [ class "application-detail" ] (view ++ views)


list : WebData (List App) -> Html msg
list data =
    let
        listView =
            case data of
                RemoteData.Success apps ->
                    List.map row apps

                _ ->
                    dataview data
    in
        div [ class "application-list" ]
            listView


row : App -> Html msg
row app =
    div [ class "application-row" ]
        [ a [ Route.href (Route.Application app.id) ]
            [ text (app.movie.title ++ " - " ++ (fullname app.person)) ]
        ]
