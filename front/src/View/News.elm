module View.News exposing (detail, list)

import Data.News exposing (News)
import View.Util exposing (dataview)
import Html exposing (..)
import Html.Attributes exposing (..)
import RemoteData exposing (WebData)
import Route


detail : WebData News -> Html msg
detail data =
    div [ class "news-detail" ] (dataview data newsDetail)


list : WebData (List News) -> Html msg
list data =
    div [ class "news-list" ] (dataview data newsList)



-- INTERNALS --


newsDetail : News -> List (Html msg)
newsDetail news =
    [ h1 [ class "news-title" ] [ text news.title ]
    , p [ class "news-author" ] [ text ("Par " ++ news.author) ]
    , p [ class "news-pub" ] [ text ("le " ++ news.pub) ]
    , p [ class "news-content" ] [ text news.content ]
    ]


newsList : List News -> List (Html msg)
newsList feed =
    List.map newsRow feed


newsRow : News -> Html msg
newsRow news =
    div [ class "news-row" ]
        [ h2 [ class "news-title" ] [ text news.title ]
        , p [ class "news-author" ] [ text ("Par " ++ news.author) ]
        , p [ class "news-pub" ] [ text ("le " ++ news.pub) ]
        , p [ class "news-summary" ] [ text news.summary ]
        , a [ Route.href (Route.News news.id) ] [ text "Read more ..." ]
        ]
