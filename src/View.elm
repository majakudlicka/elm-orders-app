module View exposing (..)

import Html exposing (Html, div, text)
import Models exposing (Model, OrderId)
import Models exposing (Model)
import Msgs exposing (Msg)
import Orders.Edit
import Orders.List
import RemoteData


view : Model -> Html Msg
view model =
    div []
        [ page model ]


page : Model -> Html Msg
page model =
    case model.route of
        Models.OrdersRoute ->
            Orders.List.view model.orders

        Models.OrderRoute id ->
            orderEditPage model id

        Models.NotFoundRoute ->
            notFoundView


orderEditPage : Model -> OrderId -> Html Msg
orderEditPage model orderId =
    case model.orders of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading ..."

        RemoteData.Success orders ->
            let
                maybeOrder =
                    orders
                        |> List.filter (\order -> order.id == orderId)
                        |> List.head
            in
                case maybeOrder of
                    Just order ->
                        Orders.Edit.view order

                    Nothing ->
                        notFoundView

        RemoteData.Failure err ->
            text (toString err)


notFoundView : Html msg
notFoundView =
    div []
        [ text "Not found"
        ]
