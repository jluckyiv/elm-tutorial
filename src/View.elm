module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, PlayerId)
import Msgs exposing (Msg)
import Players.Edit
import Players.List
import RemoteData


view : Model -> Html Msg
view model =
    div [] [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.PlayersRoute ->
            playersListPage model

        Models.PlayerRoute id ->
            playerEditPage model id

        Models.NotFoundRoute ->
            notFoundView


playersListPage : Model -> Html Msg
playersListPage model =
    Players.List.view model.players


playerEditPage : Model -> PlayerId -> Html Msg
playerEditPage model id =
    case model.players of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading...."

        RemoteData.Success players ->
            let
                maybePlayer =
                    players
                        |> List.filter (\player -> player.id == id)
                        |> List.head
            in
                case maybePlayer of
                    Just player ->
                        Players.Edit.view player

                    Nothing ->
                        notFoundView

        RemoteData.Failure error ->
            text (toString error)


notFoundView : Html Msg
notFoundView =
    div [] [ text "Not found" ]
