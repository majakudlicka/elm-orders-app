module Routing exposing (..)

import Navigation exposing (Location)
import Models exposing (OrderId, Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map OrdersRoute top
        , map OrderRoute (s "orders" </> string)
        , map OrdersRoute (s "orders")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


ordersPath : String
ordersPath =
    "#orders"


orderPath : OrderId -> String
orderPath id =
    "#orders/" ++ id
