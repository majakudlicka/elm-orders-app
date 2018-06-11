module Commands exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required)
import Json.Encode as Encode
import Msgs exposing (Msg)
import Models exposing (OrderId, Order)
import RemoteData


fetchOrders : Cmd Msg
fetchOrders =
    Http.get fetchOrdersUrl ordersDecoder
        |> RemoteData.sendRequest
        |> Cmd.map Msgs.OnFetchOrders


fetchOrdersUrl : String
fetchOrdersUrl =
    "http://localhost:4000/orders"


saveOrderUrl : OrderId -> String
saveOrderUrl orderId =
    "http://localhost:4000/orders/" ++ orderId


saveOrderRequest : Models.Order -> Http.Request Models.Order
saveOrderRequest order =
    Http.request
        { body = orderEncoder order |> Http.jsonBody
        , expect = Http.expectJson orderDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = saveOrderUrl order.id
        , withCredentials = False
        }


saveOrderCmd : Models.Order -> Cmd Msg
saveOrderCmd order =
    saveOrderRequest order
        |> Http.send Msgs.OnOrderSave



-- DECODERS


ordersDecoder : Decode.Decoder (List Models.Order)
ordersDecoder =
    Decode.list orderDecoder


orderDecoder : Decode.Decoder Models.Order
orderDecoder =
    decode Order
        |> required "id" Decode.string
        |> required "name" Decode.string
        |> required "quantity" Decode.int


orderEncoder : Models.Order -> Encode.Value
orderEncoder order =
    let
        attributes =
            [ ( "id", Encode.string order.id )
            , ( "name", Encode.string order.name )
            , ( "quantity", Encode.int order.quantity )
            ]
    in
        Encode.object attributes
