module Data.Edition
    exposing
        ( Edition
        , EditionId
        , eidStr
        , eidParser
        , editionsDecoder
        , decoder
        )

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import UrlParser


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



-- IDENTIFIERS--


type EditionId
    = EditionId Int


eidStr : EditionId -> String
eidStr (EditionId eid) =
    toString eid


eidParser : UrlParser.Parser (EditionId -> a) a
eidParser =
    UrlParser.custom "EDITIONID" strEid



-- SERIALIZERS --


editionsDecoder : Decoder (List Edition)
editionsDecoder =
    Decode.list decoder


decoder : Decoder Edition
decoder =
    decode Edition
        |> required "id" (Decode.map EditionId Decode.int)
        |> required "name" Decode.string
        |> required "localisation" Decode.string
        |> required "start_date" Decode.string
        |> required "nomination_date" Decode.string
        |> required "rewarding_date" Decode.string
        |> required "end_date" Decode.string
        |> required "step" Decode.string
        |> required "url_awards" Decode.string



-- INTERNALS --


strEid : String -> Result String EditionId
strEid str =
    case String.toInt str of
        Ok i ->
            Ok (EditionId i)

        Err err ->
            Err err
