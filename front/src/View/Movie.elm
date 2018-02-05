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
    div [ class "article-list" ] (dataview data listArticle)


articleDetail : WebData Article -> Html msg
articleDetail data =
    div [ class "article-detail" ] (dataview data detailArticle)


interviewList : WebData (List Interview) -> Html msg
interviewList data =
    div [ class "interview-list" ] (dataview data listInterview)


interviewDetail : WebData Interview -> Html msg
interviewDetail data =
    div [ class "interview-detail" ] (dataview data detailInterview)



-- INTERNALS --


listArticle : List Article -> List (Html msg)
listArticle articles =
    (h2 [] [ text "Articles" ])
        :: (List.map articleRow articles)


detailArticle : Article -> List (Html msg)
detailArticle article =
    [ h1 [] [ text article.title ]
    , p [] [ text article.content ]
    ]


articleRow : Article -> Html msg
articleRow article =
    div [ class "article-row" ]
        [ a [ Route.href (Route.Article article.id) ]
            [ text ("Article: " ++ article.title) ]
        ]


listInterview : List Interview -> List (Html msg)
listInterview interviews =
    (h2 [] [ text "Interviews" ])
        :: (List.map interviewRow interviews)


detailInterview : Interview -> List (Html msg)
detailInterview interview =
    [ h1 [] [ text interview.title ]
    , iframe
        [ width 420
        , height 315
        , src interview.video
        ]
        []
    ]


interviewRow : Interview -> Html msg
interviewRow interview =
    div [ class "interview-row" ]
        [ a [ Route.href (Route.Interview interview.id) ]
            [ text ("Interview: " ++ interview.title) ]
        ]
