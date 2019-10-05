module CustomListing exposing (columns, config, customTableModel, getListItems, tonToString)

import CustomTable.CustomTable as CustomTable exposing (init, initState, renderInt, renderString, update, view)
import CustomTable.CustomTableType as CustomTableType exposing (Accessor(..), Column, Config, Filter(..), Item, Model, Msg(..), State, ValueFilter(..))
import Date exposing (Date)
import Model exposing (..)


getListItems : List Ad -> List (Item Ad)
getListItems data =
    data


tonToString : Ton -> String
tonToString ton =
    case ton of
        Standard ->
            "Standard"

        Funky ->
            "Funky"


config : List Ad -> Config Ad Model.Msg
config data =
    { canSelectRows = True
    , columns = columns data
    }


columns : List Ad -> List (Column Ad Model.Msg)
columns data =
    [ { properties =
            { id = "startdate"
            , sortable = True
            , title = String.toUpper "Start Date"
            , visible = True
            }
      , filter = ValueFilter
      , dataForFilter = StringValueFilter <| List.map (\item -> Date.toIsoString item.startDate) data
      , accessor = GetString (\item -> Date.toIsoString item.startDate)
      , render = renderString (\item -> Date.toIsoString item.startDate)
      }
    , { properties =
            { id = "enddate"
            , sortable = True
            , title = String.toUpper "End Date"
            , visible = True
            }
      , filter = ValueFilter
      , dataForFilter = StringValueFilter <| List.map (\item -> Date.toIsoString item.endDate) data
      , accessor = GetString (\item -> Date.toIsoString item.endDate)
      , render = renderString (\item -> Date.toIsoString item.endDate)
      }
    , { properties =
            { id = "minage"
            , sortable = True
            , title = String.toUpper "Min Age"
            , visible = True
            }
      , filter = ValueFilter
      , dataForFilter = IntValueFilter <| List.map .minAge data
      , accessor = GetInt .minAge
      , render = renderInt .minAge
      }
    , { properties =
            { id = "maxage"
            , sortable = True
            , title = String.toUpper "Max Age"
            , visible = True
            }
      , filter = ValueFilter
      , dataForFilter = IntValueFilter <| List.map .maxAge data
      , accessor = GetInt .maxAge
      , render = renderInt .maxAge
      }
    , { properties =
            { id = "ton"
            , sortable = True
            , title = String.toUpper "ton"
            , visible = True
            }
      , filter = ValueFilter
      , dataForFilter = StringValueFilter <| List.map (\item -> tonToString item.ton) data
      , accessor = GetString (\item -> tonToString item.ton)
      , render = renderString (\item -> tonToString item.ton)
      }
    ]


customTableModel : Listing -> CustomTableType.Model Ad Model.Msg
customTableModel model =
    CustomTable.init model.state
        (getListItems model.data)
        (config model.data)
        False
        50
        100
