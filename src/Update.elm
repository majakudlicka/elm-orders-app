module Update exposing (..)

import Commands exposing (saveOrderCmd)
import Models exposing (Model, Order)
import Msgs exposing (Msg)
import Routing exposing (parseLocation)
import RemoteData


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msgs.OnFetchOrders response ->
            ( { model | orders = response }, Cmd.none )

        Msgs.OnLocationChange location ->
            let
                newRoute =
                    parseLocation location
            in
                ( { model | route = newRoute }, Cmd.none )

        Msgs.ChangeQuantity order howMuch ->
            let
                updatedOrder =
                    { order | quantity = order.quantity + howMuch }
            in
                ( model, saveOrderCmd updatedOrder )

        Msgs.OnOrderSave (Ok order) ->
            ( updateOrder model order, Cmd.none )

        Msgs.OnOrderSave (Err error) ->
            ( model, Cmd.none )


updateOrder : Model -> Models.Order -> Model
updateOrder model updatedOrder =
    let
        pick currentOrder =
            if updatedOrder.id == currentOrder.id then
                updatedOrder
            else
                currentOrder

        updateOrderList orders =
            List.map pick orders

        updatedOrders =
            RemoteData.map updateOrderList model.orders
    in
        { model | orders = updatedOrders }
