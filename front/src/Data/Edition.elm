module Data.Edition exposing (..)

import UrlParser
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required, decode)


type alias Edition =
    { id : EditionId
    , name : String
    , localisation : String
    , start : String
    , nomination : String
    , rewarding : String
    , end : String
    , step : String
    , awards : String
    }


type EditionId
    = EditionId String


eidStr : EditionId -> String
eidStr (EditionId eid) =
    eid


eidParser : UrlParser.Parser (EditionId -> a) a
eidParser =
    UrlParser.custom "EDITIONID" (Ok << EditionId)


decoder : Decoder Edition
decoder =
    decode Edition
        |> required "id" (Decode.map EditionId Decode.string)
        |> required "name" Decode.string
        |> required "localisation" Decode.string
        |> required "start_date" Decode.string
        |> required "nomination_date" Decode.string
        |> required "rewarding_date" Decode.string
        |> required "end_date" Decode.string
        |> required "step" Decode.string
        |> required "url_awards" Decode.string


editionsDecoder : Decoder (List Edition)
editionsDecoder =
    Decode.list decoder
