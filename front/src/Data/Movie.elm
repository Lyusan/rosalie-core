module Data.Movie exposing (..)

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


articleDecoder : Decoder Article
articleDecoder =
    decode Article
        |> required "id" Decode.int
        |> required "title" Decode.string
        |> required "content" Decode.string


articlesDecoder : Decoder (List Article)
articlesDecoder =
    Decode.list articleDecoder


interviewDecoder : Decoder Interview
interviewDecoder =
    decode Interview
        |> required "id" Decode.int
        |> required "title" Decode.string
        |> required "video" Decode.string


interviewsDecoder : Decoder (List Interview)
interviewsDecoder =
    Decode.list interviewDecoder
