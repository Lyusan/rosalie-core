module Request.Edition exposing (..)

import Data.Award exposing (Award, AwardId, aidStr, awardsDecoder)
import Data.Edition exposing (..)
import Http
import Request.Api exposing (apiUrl)


editionsUrl : String
editionsUrl =
    apiUrl ++ "/events"


editionUrl : EditionId -> String
editionUrl eid =
    editionsUrl ++ "/" ++ eidStr eid


editionAwardsUrl : EditionId -> String
editionAwardsUrl eid =
    editionUrl eid ++ "/awards"


listEditions : Http.Request (List Edition)
listEditions =
    Http.get editionsUrl editionsDecoder


retrieveEdition : EditionId -> Http.Request Edition
retrieveEdition eid =
    Http.get (editionUrl eid) decoder


listEditionAwards : EditionId -> Http.Request (List Award)
listEditionAwards eid =
    Http.get (editionAwardsUrl eid) awardsDecoder
