module Main exposing (main)

import Browser
import Date exposing (Date)
import Html exposing (Html, pre, text)
import Http



-- MAIN


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type Thematic
    = Standard
    | Funky


type alias AdInput =
    { startDate : Maybe Date
    , endDate : Maybe Date
    , thematic : Maybe Thematic
    , minAge : Maybe Int
    , maxAge : Maybe Int
    }


type alias Ad =
    { startDate : Date
    , endDate : Date
    , minAge : Int
    , maxAge : Int
    , thematic : Thematic
    }


type Model
    = CreationForm AdInput
    | Listing (List Ad)


initialAdInput =
    { startDate = Nothing
    , endDate = Nothing
    , thematic = Nothing
    , minAge = Nothing
    , maxAge = Nothing
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( CreationForm initialAdInput
    , Cmd.none
    )



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
