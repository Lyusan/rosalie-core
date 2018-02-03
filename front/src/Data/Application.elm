module Data.Application exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import UrlParser


type alias App =
    { id : AppId
    , movie : Movie
    , person : Person
    }


type alias Movie =
    { id : Int
    , title : String
    , desc : String
    , date : String
    , img : String
    , articles : String
    , interviews : String
    }


type alias Person =
    { id : Int
    , firstname : String
    , lastname : String
    , birthdate : String
    , desc : String
    , img : String
    }


fullname : Person -> String
fullname person =
    person.firstname ++ " " ++ person.lastname


type AppId
    = AppId Int


appidInt : AppId -> Int
appidInt (AppId appid) =
    appid


appidStr : AppId -> String
appidStr (AppId appid) =
    toString appid


strAppid : String -> Result String AppId
strAppid str =
    case String.toInt str of
        Ok i ->
            Ok (AppId i)

        Err err ->
            Err err


appidParser : UrlParser.Parser (AppId -> a) a
appidParser =
    UrlParser.custom "APPID" strAppid


decoder : Decoder App
decoder =
    decode App
        |> required "id" (Decode.map AppId Decode.int)
        |> required "movie" movieDecoder
        |> required "person" personDecoder


movieDecoder : Decoder Movie
movieDecoder =
    decode Movie
        |> required "id" Decode.int
        |> required "title" Decode.string
        |> required "desc" Decode.string
        |> required "date" Decode.string
        |> required "img" Decode.string
        |> required "url_articles" Decode.string
        |> required "url_interviews" Decode.string


personDecoder : Decoder Person
personDecoder =
    decode Person
        |> required "id" Decode.int
        |> required "firstname" Decode.string
        |> required "lastname" Decode.string
        |> required "birthdate" Decode.string
        |> required "desc" Decode.string
        |> required "img" Decode.string


appsDecoder : Decoder (List App)
appsDecoder =
    Decode.list decoder
