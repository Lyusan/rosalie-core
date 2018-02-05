module View.News exposing (detail, list)

import Data.News exposing (News)
import View.Util exposing (dataview)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Route


detail : WebData News -> Html msg
detail data =
    let
        view =
            case data of
                RemoteData.Success news ->
                    [ h1 [ class "news-title" ] [ text news.title ]
                    , p [ class "news-author" ] [ text ("Par " ++ news.author) ]
                    , p [ class "news-pub" ] [ text ("le " ++ news.pub) ]
                    , p [ class "news-content" ] [ text news.content ]
                    ]

                _ ->
                    dataview data
    in
        div [ class "news-detail" ] view


list : WebData (List News) -> Html msg
list data =
    let
        view =
            case data of
                RemoteData.Success feed ->
                    List.map row feed

                _ ->
                    dataview data
    in
        div [ class "news-list" ] view


row : News -> Html msg
row news =
    div [ class "news-row" ]
        [ h2 [ class "news-title" ] [ text news.title ]
        , p [ class "news-author" ] [ text ("Par " ++ news.author) ]
        , p [ class "news-pub" ] [ text ("le " ++ news.pub) ]
        , p [ class "news-summary" ] [ text news.summary ]
        , a [ Route.href (Route.News news.id) ] [ text "Read more ..." ]
        ]
