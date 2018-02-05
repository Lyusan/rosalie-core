module Request.Edition
    exposing
        ( listEditions
        , retrieveEdition
        , listEditionAwards
        )

import Data.Award exposing (Award, AwardId, aidStr, awardsDecoder)
import Data.Edition exposing (Edition, EditionId, editionsDecoder, decoder, eidStr)
import Request.Api exposing (apiUrl)
import Http


listEditions : Http.Request (List Edition)
listEditions =
    Http.get editionsUrl editionsDecoder


retrieveEdition : EditionId -> Http.Request Edition
retrieveEdition eid =
    Http.get (editionUrl eid) decoder


listEditionAwards : EditionId -> Http.Request (List Award)
listEditionAwards eid =
    Http.get (editionAwardsUrl eid) awardsDecoder



-- INTERNALS --


editionsUrl : String
editionsUrl =
    apiUrl ++ "/events"


editionUrl : EditionId -> String
editionUrl eid =
    editionsUrl ++ "/" ++ eidStr eid


editionAwardsUrl : EditionId -> String
editionAwardsUrl eid =
    editionUrl eid ++ "/awards"
