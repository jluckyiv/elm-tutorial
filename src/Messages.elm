module Messages exposing (..)

import Http
import Models exposing (Player)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = ChangeLevel Player Int
    | ChangeLocation String
    | OnFetchPlayers (WebData (List Player))
    | OnLocationChange Location
    | OnPlayerSave (Result Http.Error Player)
