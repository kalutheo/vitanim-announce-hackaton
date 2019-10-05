module Main exposing (main)

import Browser
import Date exposing (Date)
import Html exposing (Html, pre, text)
import Http
import Validate exposing (Validator, ifBlank, ifTrue, validate)



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


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
    { startDate : Date
    , endDate : Date
    , minAge : Int
    , maxAge : Int
    , ton : Ton
    }


type Model
    = CreationForm AdInput
    | Listing (List Ad)


initialAdInput =
    { startDate = Nothing
    , endDate = Nothing
    , minAge = Nothing
    , maxAge = Nothing
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( CreationForm initialAdInput
    , Cmd.none
    )


type Field
    = StartDate
    | EndDate
    | MinAge
    | MaxAge


type alias FieldError =
    ( Field, String )


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
            { startDate = a
            , endDate = b
            , minAge = c
            , maxAge = d
            , ton = Standard
            }
        )
        startDate
        endDate
        minAge
        maxAge



-- UPDATE


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
    case model of
        CreationForm adInput ->
            Html.text "Input Form"

        Listing adListing ->
            Html.text "Go Thomas :)"
