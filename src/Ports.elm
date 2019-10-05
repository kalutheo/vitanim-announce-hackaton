port module Ports exposing (scrolledTo, updateCustomTable)

import CustomTable.CustomTableType as CustomTableType


port updateCustomTable : Bool -> Cmd msg


port scrolledTo : (CustomTableType.ScrollEvent -> a) -> Sub a
