module Models exposing (..)

import RemoteData exposing (WebData)


type alias Model =
    { orders : WebData (List Order)
    , route : Route
    }


initialModel : Route -> Model
initialModel route =
    { orders = RemoteData.Loading
    , route = route
    }


type alias OrderId =
    String


type alias Order =
    { id : OrderId
    , name : String
    , quantity : Int
    }


type Route
    = OrdersRoute
    | OrderRoute OrderId
    | NotFoundRoute
