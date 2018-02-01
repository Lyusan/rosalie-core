module Request.Edition exposing (..)

import Http
import Request.Api exposing (apiUrl)
import Data.Edition exposing (..)


editionsUrl : String
editionsUrl =
    apiUrl ++ "/events"


editionUrl : EditionId -> String
editionUrl eid =
    editionsUrl ++ "/" ++ eidStr eid


listEditions : Http.Request (List Edition)
listEditions =
    Http.get editionsUrl editionsDecoder


retrieveEdition : EditionId -> Http.Request Edition
retrieveEdition eid =
    Http.get (editionUrl eid) decoder
