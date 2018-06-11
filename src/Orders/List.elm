module Orders.List exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, style)
import Models exposing (Order)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Routing exposing (orderPath)


view : WebData (List Models.Order) -> Html Msg
view response =
    div []
        [ nav
        , maybeList response
        ]


nav : Html Msg
nav =
    div [ class "clearfix mb2 white bg-black" ]
        [ div [ class "left p2" ] [ text "Orders" ] ]


maybeList : WebData (List Models.Order) -> Html Msg
maybeList response =
    case response of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Success orders ->
            list orders

        RemoteData.Failure error ->
            text (toString error)


list : List Models.Order -> Html Msg
list orders =
    div [ class "p2" ]
        [ table []
            [ thead []
                [ tr []
                    [ th [ style [ ( "min-width", "100px" ), ("text-align", "center") ] ] [ text "Id" ]
                    , th [ style [ ( "min-width", "100px" ), ("text-align", "center") ] ] [ text "Name" ]
                    , th [ style [ ( "min-width", "100px" ), ("text-align", "center") ] ] [ text "Quantity" ]
                    , th [ style [ ( "min-width", "100px" ), ("text-align", "center") ] ] [ text "Edit" ]
                    ]
                ]
            , tbody [] (List.map orderRow orders)
            ]
        ]


orderRow : Models.Order -> Html Msg
orderRow order =
    tr []
        [ td [ style [ ( "min-width", "100px" ), ("text-align", "center") ] ] [ text order.id ]
        , td [ style [ ( "min-width", "100px" ), ("text-align", "center") ] ] [ text order.name ]
        , td [style [ ( "min-width", "100px" ), ("text-align", "center") ] ] [ text (toString order.quantity) ]
        , td [style [ ( "min-width", "100px" ), ("text-align", "center") ] ]
            [ editBtn order ]
        ]


editBtn : Models.Order -> Html.Html Msg
editBtn order =
    let
        path =
            orderPath order.id
    in
        a
            [ class "btn regular"
            , href path
            ]
            [ i [ class "fa fa-pencil mr1" ] [] ]
