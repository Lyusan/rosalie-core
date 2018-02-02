module Request.Award exposing (..)

import Data.Award exposing (..)
import Http
import Request.Api exposing (apiUrl)


awardsUrl : String
awardsUrl =
    apiUrl ++ "/awards"


awardUrl : AwardId -> String
awardUrl aid =
    awardsUrl ++ "/" ++ aidStr aid


listAwards : Http.Request (List Award)
listAwards =
    Http.get awardsUrl awardsDecoder


retrieveAward : AwardId -> Http.Request Award
retrieveAward aid =
    Http.get (awardUrl aid) decoder
