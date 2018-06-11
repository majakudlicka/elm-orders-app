module Msgs exposing (..)

import Http
import Models exposing (Order, OrderId)
import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnFetchOrders (WebData (List Models.Order))
    | OnLocationChange Location
    | ChangeQuantity Models.Order Int
    | OnOrderSave (Result Http.Error Models.Order)
