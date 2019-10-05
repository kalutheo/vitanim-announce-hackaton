module Model exposing (Ad, AdInput, Field(..), FieldError, Listing, Model(..), Msg(..), Ton(..), emptyAdListing)

import CustomTable.CustomTable as CustomTable exposing (initState)
import CustomTable.CustomTableType as CustomTableType exposing (Accessor(..), Column, Config, Filter(..), Item, Model, Msg(..), State, ValueFilter(..))
import Date exposing (Date)


type Ton
    = Standard
    | Funky


type alias AdInput =
    { startDate : Maybe Date
    , endDate : Maybe Date
    , minAge : Maybe Int
    , maxAge : Maybe Int
    }


type alias Ad =
    { index : Int
    , selected : Bool
    , startDate : Date
    , endDate : Date
    , minAge : Int
    , maxAge : Int
    , ton : Ton
    }


type alias Listing =
    { state : CustomTableType.State
    , data : List Ad
    }


emptyAdListing : Listing
emptyAdListing =
    Listing (CustomTable.initState -1) []


type Model
    = CreationForm AdInput
    | ListingData Listing


type Msg
    = NoOp
    | ScrolledTo CustomTableType.ScrollEvent
    | CustomTableMsg (CustomTableType.Msg Msg)
    | ChangeField Field String


type Field
    = StartDate
    | EndDate
    | MinAge
    | MaxAge


type alias FieldError =
    ( Field, String )
