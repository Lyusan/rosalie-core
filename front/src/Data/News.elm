module Data.News
    exposing
        ( News
        , NewsId
        , nidStr
        , newsidParser
        , feedDecoder
        , decoder
        )

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import UrlParser


type alias News =
    { id : NewsId
    , title : String
    , author : String
    , pub : String
    , summary : String
    , content : String
    }



-- IDENTIFIERS --


type NewsId
    = NewsId Int


nidStr : NewsId -> String
nidStr (NewsId nid) =
    toString nid


newsidParser : UrlParser.Parser (NewsId -> a) a
newsidParser =
    UrlParser.custom "NEWSID" strNid



-- SERIALIZERS --


feedDecoder : Decoder (List News)
feedDecoder =
    Decode.list decoder


decoder : Decoder News
decoder =
    decode News
        |> required "id" (Decode.map NewsId Decode.int)
        |> required "title" Decode.string
        |> required "author" Decode.string
        |> required "pub_date" Decode.string
        |> required "summary" Decode.string
        |> required "content" Decode.string



-- INTERNALS --


strNid : String -> Result String NewsId
strNid str =
    case String.toInt str of
        Ok i ->
            Ok (NewsId i)

        Err err ->
            Err err
