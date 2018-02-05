module Data.Util exposing (strId)


strId : (Int -> a) -> String -> Result String a
strId id str =
    case String.toInt str of
        Ok i ->
            Ok (id i)

        Err err ->
            Err err
