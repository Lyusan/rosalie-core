module Data.Award exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import UrlParser


type alias Award =
    { id : AwardId
    , name : String
    , desc : String
    , applications : String
    }


type AwardId
    = AwardId Int


aidInt : AwardId -> Int
aidInt (AwardId aid) =
    aid


aidStr : AwardId -> String
aidStr (AwardId aid) =
    toString aid


strAid : String -> Result String AwardId
strAid str =
    case String.toInt str of
        Ok i ->
            Ok (AwardId i)

        Err err ->
            Err err


aidParser : UrlParser.Parser (AwardId -> a) a
aidParser =
    UrlParser.custom "AWARDID" strAid


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
