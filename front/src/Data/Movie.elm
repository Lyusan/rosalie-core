module Data.Movie
    exposing
        ( Article
        , Interview
        , articlesDecoder
        , articleDecoder
        , interviewsDecoder
        , interviewDecoder
        )

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)


type alias Article =
    { id : Int
    , title : String
    , content : String
    }


type alias Interview =
    { id : Int
    , title : String
    , video : String
    }



-- SERIALIZERS --


articlesDecoder : Decoder (List Article)
articlesDecoder =
    Decode.list articleDecoder


interviewsDecoder : Decoder (List Interview)
interviewsDecoder =
    Decode.list interviewDecoder


articleDecoder : Decoder Article
articleDecoder =
    decode Article
        |> required "id" Decode.int
        |> required "title" Decode.string
        |> required "content" Decode.string


interviewDecoder : Decoder Interview
interviewDecoder =
    decode Interview
        |> required "id" Decode.int
        |> required "title" Decode.string
        |> required "url_video" Decode.string
