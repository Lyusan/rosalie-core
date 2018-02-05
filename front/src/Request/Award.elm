module Request.Award
    exposing
        ( listAwards
        , retrieveAward
        , retrieveWinner
        , listApplications
        )

import Data.Award exposing (Award, AwardId, aidStr, awardsDecoder, decoder)
import Data.Application as App
import Request.Api exposing (apiUrl)
import Http


listAwards : Http.Request (List Award)
listAwards =
    Http.get awardsUrl awardsDecoder


retrieveAward : AwardId -> Http.Request Award
retrieveAward aid =
    Http.get (awardUrl aid) decoder


retrieveWinner : AwardId -> Http.Request App.App
retrieveWinner aid =
    Http.get (winnerUrl aid) App.decoder


listApplications : AwardId -> Bool -> Http.Request (List App.App)
listApplications aid bool =
    Http.get (applicationsUrl bool aid) App.appsDecoder



-- INTERNALS --


awardsUrl : String
awardsUrl =
    apiUrl ++ "/awards"


awardUrl : AwardId -> String
awardUrl aid =
    awardsUrl ++ "/" ++ aidStr aid


winnerUrl : AwardId -> String
winnerUrl aid =
    awardUrl aid ++ "/winner"


applicationsUrl : Bool -> AwardId -> String
applicationsUrl bool aid =
    let
        url =
            if bool then
                nomineesUrl
            else
                candidatesUrl
    in
        url aid


candidatesUrl : AwardId -> String
candidatesUrl aid =
    (awardUrl aid) ++ "/applications?nominees=false"


nomineesUrl : AwardId -> String
nomineesUrl aid =
    (awardUrl aid) ++ "/applications?nominees=true"
