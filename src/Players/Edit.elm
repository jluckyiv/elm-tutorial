module Players.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)
import View.Helpers exposing (onLinkClick)
import Messages exposing (Msg)
import Models exposing (Player)
import Routing exposing (playersPath)


view : Player -> Html Msg
view player =
    div []
        [ nav player
        , form player
        ]


nav : Player -> Html Msg
nav player =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


form : Player -> Html Msg
form player =
    div [ class "m3" ]
        [ h1 [] [ text player.name ]
        , formLevel player
        ]


formLevel : Player -> Html Msg
formLevel player =
    div [ class "clearfix py1" ]
        [ div [ class "col col-5" ] [ text "Level" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString player.level) ]
            , btnLevelDecrease player
            , btnLevelIncrease player
            ]
        ]


btnLevelDecrease : Player -> Html Msg
btnLevelDecrease player =
    let
        message =
            Messages.ChangeLevel player -1
    in
        a [ class "btn ml1h1" ]
            [ i [ class "fa fa-minus-circle", onClick message ] [] ]


btnLevelIncrease : Player -> Html Msg
btnLevelIncrease player =
    let
        message =
            Messages.ChangeLevel player 1
    in
        a [ class "btn ml1h1" ]
            [ i [ class "fa fa-plus-circle", onClick message ] [] ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href playersPath
        , onLinkClick (Messages.ChangeLocation playersPath)
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
