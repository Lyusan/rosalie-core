module View.News exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Data.News exposing (..)


detail : News -> Html msg
detail news =
    div [ class "news-detail" ]
        [ h1 [ class "news-title" ] [ text news.title ]
        , p [ class "news-author" ] [ text ("Par " ++ news.author) ]
        , p [ class "news-pub" ] [ text ("le " ++ news.pub) ]
        , p [ class "news-content" ] [ text news.content ]
        ]


list : List News -> Html msg
list news =
    div [ class "news-list" ]
        (List.map row news)


row : News -> Html msg
row news =
    div [ class "news-row" ]
        [ h2 [ class "news-title" ] [ text news.title ]
        , p [ class "news-author" ] [ text ("Par " ++ news.author) ]
        , p [ class "news-pub" ] [ text ("le " ++ news.pub) ]
        , p [ class "news-summary" ] [ text news.summary ]
        ]
