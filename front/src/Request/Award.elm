module Request.Award exposing (..)

import Data.Award exposing (..)
import Data.Application as App
import Http
import Request.Api exposing (apiUrl)


awardsUrl : String
awardsUrl =
    apiUrl ++ "/awards"


awardUrl : AwardId -> String
awardUrl aid =
    awardsUrl ++ "/" ++ aidStr aid


winnerUrl : AwardId -> String
winnerUrl aid =
    awardUrl aid ++ "/winner"


listAwards : Http.Request (List Award)
listAwards =
    Http.get awardsUrl awardsDecoder


retrieveAward : AwardId -> Http.Request Award
retrieveAward aid =
    Http.get (awardUrl aid) decoder


retrieveWinner : AwardId -> Http.Request App.App
retrieveWinner aid =
    Http.get (winnerUrl aid) App.decoder
