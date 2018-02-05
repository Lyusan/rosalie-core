module View.Application exposing (detail, list)

import Data.Application exposing (App, fullname)
import View.Util exposing (dataview)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Route


detail : WebData App -> List (Html msg) -> Html msg
detail data appArticlesInterviews =
    div [ class "application-detail" ]
        ((dataview data appDetail) ++ appArticlesInterviews)


list : WebData (List App) -> Html msg
list data =
    div [ class "application-list" ]
        ([ h1 [] [ text "Winners" ] ]
            ++ (dataview data appList)
        )



-- INTERNALS --


appDetail : App -> List (Html msg)
appDetail app =
    [ h1 []
        [ text (app.movie.title ++ " - " ++ (fullname app.person)) ]
    , h2 [] [ text app.movie.title ]
    , p [] [ text app.movie.desc ]
    , h2 [] [ text (fullname app.person) ]
    , p [] [ text app.person.desc ]
    ]


appList : List App -> List (Html msg)
appList apps =
    List.map appRow apps


appRow : App -> Html msg
appRow app =
    div [ class "application-row" ]
        [ a [ Route.href (Route.Application app.id) ]
            [ text (app.movie.title ++ " - " ++ (fullname app.person)) ]
        ]
