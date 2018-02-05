module Data.Award
    exposing
        ( Award
        , AwardId
        , aidStr
        , aidParser
        , awardsDecoder
        , decoder
        )

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import UrlParser


type alias Award =
    { id : AwardId
    , name : String
    , desc : String
    , applications : String
    }



-- IDENTIFIERS --


type AwardId
    = AwardId Int


aidStr : AwardId -> String
aidStr (AwardId aid) =
    toString aid


aidParser : UrlParser.Parser (AwardId -> a) a
aidParser =
    UrlParser.custom "AWARDID" strAid



-- SERIALIZERS--


decoder : Decoder Award
decoder =
    decode Award
        |> required "id" (Decode.map AwardId Decode.int)
        |> required "categorie_name" Decode.string
        |> required "categorie_desc" Decode.string
        |> required "url_applications" Decode.string


awardsDecoder : Decoder (List Award)
awardsDecoder =
    Decode.list decoder



-- INTERNALS --


strAid : String -> Result String AwardId
strAid str =
    case String.toInt str of
        Ok i ->
            Ok (AwardId i)

        Err err ->
            Err err
