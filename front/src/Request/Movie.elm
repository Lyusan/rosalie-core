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


articlesUrl : String
articlesUrl =
    apiUrl ++ "/articles"


articleUrl : Int -> String
articleUrl aid =
    (articlesUrl) ++ "/" ++ (toString aid)


interviewsUrl : String
interviewsUrl =
    apiUrl ++ "/interviews"


interviewUrl : Int -> String
interviewUrl iid =
    (interviewsUrl) ++ "/" ++ (toString iid)


listArticles : Http.Request (List Article)
listArticles =
    Http.get (articlesUrl) articlesDecoder


retrieveArticle : Int -> Http.Request Article
retrieveArticle aid =
    Http.get (articleUrl aid) articleDecoder


listInterviews : Http.Request (List Interview)
listInterviews =
    Http.get (interviewsUrl) interviewsDecoder


retrieveInterview : Int -> Http.Request Interview
retrieveInterview aid =
    Http.get (interviewUrl aid) interviewDecoder
