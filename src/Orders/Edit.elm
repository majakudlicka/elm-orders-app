module Orders.Edit exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, value, href)
import Html.Events exposing (onClick)
import Models exposing (Order)
import Msgs exposing (Msg)
import Routing exposing (ordersPath)


view : Models.Order -> Html.Html Msg
view model =
    div []
        [ nav model
        , form model
        ]


nav : Models.Order -> Html.Html Msg
nav model =
    div [ class "clearfix mb2 white bg-black p1" ]
        [ listBtn ]


form : Models.Order -> Html.Html Msg
form order =
    div [ class "m3" ]
        [ h1 [] [ text order.name ]
        , formQuantity order
        ]


formQuantity : Models.Order -> Html.Html Msg
formQuantity order =
    div
        [ class "clearfix py1"
        ]
        [ div [ class "col col-5" ] [ text "Quantity" ]
        , div [ class "col col-7" ]
            [ span [ class "h2 bold" ] [ text (toString order.quantity) ]
            , btnQuantityDecrease order
            , btnQuantityIncrease order
            ]
        ]


btnQuantityDecrease : Models.Order -> Html.Html Msg
btnQuantityDecrease order =
    let
        message =
            Msgs.ChangeQuantity order -1
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-minus-circle" ] [] ]


btnQuantityIncrease : Models.Order -> Html.Html Msg
btnQuantityIncrease order =
    let
        message =
            Msgs.ChangeQuantity order 1
    in
        a [ class "btn ml1 h1", onClick message ]
            [ i [ class "fa fa-plus-circle" ] [] ]


listBtn : Html Msg
listBtn =
    a
        [ class "btn regular"
        , href ordersPath
        ]
        [ i [ class "fa fa-chevron-left mr1" ] [], text "List" ]
