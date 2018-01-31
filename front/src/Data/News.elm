module Data.News exposing (..)

import UrlParser
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)


type alias News =
    { id : NewsId
    , title : String
    , author : String
    , pub : String
    , summary : String
    , content : String
    }


type NewsId
    = NewsId String


nidStr : NewsId -> String
nidStr (NewsId nid) =
    nid


newsidParser : UrlParser.Parser (NewsId -> a) a
newsidParser =
    UrlParser.custom "NEWSID" (Ok << NewsId)


decoder : Decoder News
decoder =
    decode News
        |> required "id" (Decode.map NewsId Decode.string)
        |> required "title" Decode.string
        |> required "author" Decode.string
        |> required "pub_date" Decode.string
        |> required "summary" Decode.string
        |> required "content" Decode.string


feedDecoder : Decoder (List News)
feedDecoder =
    Decode.list decoder
