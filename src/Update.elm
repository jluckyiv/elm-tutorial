module Update exposing (..)

import Commands
import Msgs exposing (..)
import Models exposing (Model, Player)
import Routing
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeLocation path ->
            ( model, Routing.changeLocation path )

        ChangeLevel player howMuch ->
            let
                updatedPlayer =
                    { player | level = player.level + howMuch }
            in
                ( model, Commands.savePlayer updatedPlayer )

        OnFetchPlayers response ->
            ( { model | players = response }, Cmd.none )

        OnLocationChange location ->
            let
                newRoute =
                    Routing.parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        OnPlayerSave (Ok player) ->
            ( updatePlayer model player, Cmd.none )

        OnPlayerSave (Err error) ->
            ( model, Cmd.none )


updatePlayer : Model -> Player -> Model
updatePlayer model updatedPlayer =
    let
        pick currentPlayer =
            if updatedPlayer.id == currentPlayer.id then
                updatedPlayer
            else
                currentPlayer

        updatePlayerList players =
            List.map pick players

        updatedPlayers =
            RemoteData.map updatePlayerList model.players
    in
        { model | players = updatedPlayers }
