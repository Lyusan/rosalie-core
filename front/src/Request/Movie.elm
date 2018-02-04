module Request.Movie
    exposing
        ( listArticles
        , listInterviews
        , retrieveArticle
        , retrieveInterview
        )

import Data.Movie exposing (..)
import Http
import Request.Api exposing (apiUrl)


moviesUrl : String
moviesUrl =
    apiUrl ++ "/movies"


movieUrl : Int -> String
movieUrl mid =
    moviesUrl ++ "/" ++ (toString mid)


articlesUrl : Int -> String
articlesUrl mid =
    (movieUrl mid) ++ "/articles"


articleUrl : Int -> Int -> String
articleUrl mid aid =
    (articlesUrl mid) ++ "/" ++ (toString aid)


interviewsUrl : Int -> String
interviewsUrl mid =
    (movieUrl mid) ++ "/interviews"


interviewUrl : Int -> Int -> String
interviewUrl mid iid =
    (interviewsUrl mid) ++ "/" ++ (toString iid)


listArticles : Int -> Http.Request (List Article)
listArticles mid =
    Http.get (articlesUrl mid) articlesDecoder


retrieveArticle : Int -> Int -> Http.Request Article
retrieveArticle mid aid =
    Http.get (articleUrl mid aid) articleDecoder


listInterviews : Int -> Http.Request (List Interview)
listInterviews mid =
    Http.get (articlesUrl mid) interviewsDecoder


retrieveInterview : Int -> Int -> Http.Request Interview
retrieveInterview mid aid =
    Http.get (articleUrl mid aid) interviewDecoder
