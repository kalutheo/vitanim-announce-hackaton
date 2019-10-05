module Main exposing (main)

import Browser
import CustomListing exposing (..)
import CustomTable.CustomTable as CustomTable
import CustomTable.CustomTableType as CustomTableType exposing (Msg(..))
import DataSet exposing (..)
import Date exposing (Date)
import Form
import Html exposing (Html, div, pre, text)
import Html.Attributes exposing (style)
import Http
import Model exposing (..)
import Ports exposing (scrolledTo, updateCustomTable)
import Validate exposing (Validator, ifBlank, ifTrue, validate, Valid, fromValid)
import Time exposing (Month(..))



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


initialAdInput =
    { startDate = Nothing
    , endDate = Nothing
    , minAge = Nothing
    , maxAge = Nothing
    }


init : () -> ( Model.Model, Cmd Model.Msg )
init _ =
    ( -- ListingData testAdListing
      CreationForm initialAdInput
    , Cmd.none
    )


adValidator : Validator FieldError AdInput
adValidator =
    Validate.all
        [ ifTrue
            (\{ startDate, endDate } ->
                Maybe.map2 (\a b -> True) startDate endDate
                    |> Maybe.withDefault False
            )
            ( StartDate, "endDate must be later than startDate" )
        ]



-- case validate adValidator adInput of


toAd : AdInput -> Maybe Ad
toAd { startDate, endDate, minAge, maxAge } =
    Maybe.map4
        (\a b c d ->
            { index = 0
            , selected = False
            , startDate = a
            , endDate = b
            , minAge = c
            , maxAge = d
            , ton = if d < 12 then Standard else Funky
            }
        )
        startDate
        endDate
        minAge
        maxAge



-- UPDATE


update : Model.Msg -> Model.Model -> ( Model.Model, Cmd Model.Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ChangeField field value ->
            case model of
                CreationForm adInput ->
                    ( CreationForm (Form.updateAdInputByField field value adInput), Cmd.none )

                _ ->
                    ( model, Cmd.none )

        Model.ScrolledTo scrollEvent ->
            update (CustomTableMsg <| CustomTableType.ScrolledTo scrollEvent) model

        CustomTableMsg customTableMsg ->
            let
                adListing =
                    case model of
                        ListingData value ->
                            value

                        _ ->
                            emptyAdListing

                ( newState, newCmd ) =
                    CustomTable.update customTableMsg adListing.state

                newAdListing =
                    case customTableMsg of
                        Select index ->
                            ListingData
                                { adListing
                                    | data =
                                        List.map
                                            (\item ->
                                                if item.index == index then
                                                    { item | selected = not item.selected }

                                                else
                                                    item
                                            )
                                            adListing.data
                                }

                        SelectAll value filteredIndex ->
                            ListingData
                                { adListing
                                    | data =
                                        List.map
                                            (\item ->
                                                if List.member item.index filteredIndex then
                                                    { item | selected = value }

                                                else
                                                    item
                                            )
                                            adListing.data
                                    , state = newState
                                }

                        _ ->
                            ListingData { adListing | state = newState }
            in
            ( newAdListing, Cmd.batch [ updateCustomTable False, Cmd.map CustomTableMsg newCmd ] )
        Validated adInput -> ((GeneratedAd << transform << (validate adValidator)) adInput, Cmd.none)

transform : Result (List FieldError) (Valid AdInput) -> String 
transform result =
    case result of 
        Ok value -> textify (Maybe.withDefault defaultAd <| toAd (fromValid value))
        Err list -> "Something bad happened here"

defaultAd : Ad
defaultAd =
    { index = 0
        , selected = False
        , startDate = Date.fromCalendarDate 2000 Sep 27
        , endDate = Date.fromCalendarDate 2019 Sep 27
        , minAge = 0
        , maxAge = 100
        , ton = Standard
    }

textify : Ad -> String 
textify ad = 
    case ad.ton of
        Standard -> String.concat ["Standard ad for your kids aged from ", String.fromInt ad.minAge, " to ", String.fromInt ad.maxAge]
        Funky -> String.concat ["Amazing sejour for youth from ", String.fromInt ad.minAge, " to ", String.fromInt ad.maxAge]

-- SUBSCRIPTIONS


subscriptions : Model.Model -> Sub Model.Msg
subscriptions model =
    Sub.batch
        [ scrolledTo Model.ScrolledTo
        ]



-- VIEW


view : Model.Model -> Html Model.Msg
view model =
    case model of
        CreationForm adInput ->
            Form.view adInput

        ListingData adListing ->
            div [ style "height" "90vh" ] [ Html.map CustomTableMsg <| CustomTable.view adListing.state (customTableModel adListing) ]

        GeneratedAd ad -> 
            Html.text ad 
