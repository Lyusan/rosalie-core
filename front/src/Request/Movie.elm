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


interviewsUrl : Int -> String
interviewsUrl mid =
    (movieUrl mid) ++ "/interviews"


listInterviews : Int -> Http.Request (List Interview)
listInterviews mid =
    Http.get (interviewsUrl mid) interviewsDecoder


listArticles : Int -> Http.Request (List Article)
listArticles mid =
    Http.get (articlesUrl mid) articlesDecoder


articleUrl : Int -> String
articleUrl aid =
    apiUrl ++ "/articles/" ++ (toString aid)


interviewUrl : Int -> String
interviewUrl iid =
    apiUrl ++ "/interviews/" ++ (toString iid)


retrieveArticle : Int -> Http.Request Article
retrieveArticle aid =
    Http.get (articleUrl aid) articleDecoder


retrieveInterview : Int -> Http.Request Interview
retrieveInterview aid =
    Http.get (interviewUrl aid) interviewDecoder
