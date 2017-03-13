module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (PlayerId, Route(..))
import Msgs exposing (Msg)
import UrlParser exposing (..)


changeLocation : String -> Cmd Msg
changeLocation path =
    Navigation.newUrl path


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


playersPath : String
playersPath =
    "/players"


playerPath : PlayerId -> String
playerPath id =
    "/players/" ++ id
