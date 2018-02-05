module View.Movie
    exposing
        ( articleList
        , articleDetail
        , interviewList
        , interviewDetail
        )

import Data.Movie exposing (Article, Interview)
import View.Util exposing (dataview)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Route


articleList : WebData (List Article) -> Html msg
articleList data =
    let
        listView =
            case data of
                RemoteData.Success articles ->
                    List.map articleRow articles

                _ ->
                    dataview data
    in
        div [ class "article-list" ] listView


articleDetail : WebData Article -> Html msg
articleDetail data =
    let
        detailView =
            case data of
                RemoteData.Success article ->
                    [ h1 [] [ text article.title ]
                    , p [] [ text article.content ]
                    ]

                _ ->
                    dataview data
    in
        div [ class "article-detail" ] detailView


interviewList : WebData (List Interview) -> Html msg
interviewList data =
    let
        listView =
            case data of
                RemoteData.Success interviews ->
                    List.map interviewRow interviews

                _ ->
                    dataview data
    in
        div [ class "interview-list" ] listView


interviewDetail : WebData Interview -> Html msg
interviewDetail data =
    let
        detailView =
            case data of
                RemoteData.Success interview ->
                    [ h1 [] [ text interview.title ]
                    , iframe
                        [ width 420
                        , height 315
                        , src interview.video
                        ]
                        []
                    ]

                _ ->
                    dataview data
    in
        div [ class "interview-detail" ] detailView


articleRow : Article -> Html msg
articleRow article =
    div [ class "article-row" ]
        [ a [ Route.href (Route.Article article.id) ]
            [ text ("Article: " ++ article.title) ]
        ]


interviewRow : Interview -> Html msg
interviewRow interview =
    div [ class "interview-row" ]
        [ a [ Route.href (Route.Interview interview.id) ]
            [ text ("Interview: " ++ interview.title) ]
        ]
