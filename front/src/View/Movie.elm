module View.Movie exposing (..)

import RemoteData exposing (WebData)
import Html exposing (..)
import Html.Attributes exposing (..)
import Data.Movie exposing (..)
import Route


articleList : WebData (List Article) -> Html msg
articleList data =
    let
        listView =
            case data of
                RemoteData.Loading ->
                    [ text "brb" ]

                RemoteData.NotAsked ->
                    [ text "afk" ]

                RemoteData.Failure err ->
                    [ text (toString err) ]

                RemoteData.Success articles ->
                    List.map articleRow articles
    in
        div [ class "article-list" ] listView


articleRow : Article -> Html msg
articleRow article =
    div [ class "article-row" ]
        [ a [ Route.href (Route.Article article.id) ]
            [ text ("Article: " ++ article.title) ]
        ]


articleDetail : WebData Article -> Html msg
articleDetail data =
    let
        detailView =
            case data of
                RemoteData.Loading ->
                    [ text "brb" ]

                RemoteData.NotAsked ->
                    [ text "afk" ]

                RemoteData.Failure err ->
                    [ text (toString err) ]

                RemoteData.Success article ->
                    [ h1 [] [ text article.title ]
                    , p [] [ text article.content ]
                    ]
    in
        div [ class "article-detail" ] detailView


interviewList : WebData (List Interview) -> Html msg
interviewList data =
    let
        listView =
            case data of
                RemoteData.Loading ->
                    [ text "brb" ]

                RemoteData.NotAsked ->
                    [ text "afk" ]

                RemoteData.Failure err ->
                    [ text (toString err) ]

                RemoteData.Success interviews ->
                    List.map interviewRow interviews
    in
        div [ class "interview-list" ] listView


interviewRow : Interview -> Html msg
interviewRow interview =
    div [ class "interview-row" ]
        [ a [ Route.href (Route.Interview interview.id) ]
            [ text ("Interview: " ++ interview.title) ]
        ]


interviewDetail : WebData Interview -> Html msg
interviewDetail data =
    let
        detailView =
            case data of
                RemoteData.Loading ->
                    [ text "brb" ]

                RemoteData.NotAsked ->
                    [ text "afk" ]

                RemoteData.Failure err ->
                    [ text (toString err) ]

                RemoteData.Success interview ->
                    [ h1 [] [ text interview.title ]
                    , iframe
                        [ width 420
                        , height 315
                        , src interview.video
                        ]
                        []
                    ]
    in
        div [ class "interview-detail" ] detailView
