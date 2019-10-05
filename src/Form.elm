module Form exposing (updateAdInputByField, view)

import Date
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


view : AdInput -> Html Msg
view adInput =
    Html.form [onSubmit <| Validated adInput]
        [ input [ onInput (ChangeField StartDate), type_ "date", placeholder "start date" ] []
        , input [ onInput (ChangeField EndDate), type_ "date", placeholder "end date" ] []
        , input [ onInput (ChangeField MinAge), type_ "number", placeholder "min age" ] []
        , input [ onInput (ChangeField MaxAge), type_ "number", placeholder "max age" ] []
        , button [ ] [ text "Ok" ]
        ]


updateAdInputByField : Field -> String -> AdInput -> AdInput
updateAdInputByField field value adInput =
    case field of
        StartDate ->
            Date.fromIsoString value
                |> Result.map (\date -> { adInput | startDate = Just date })
                |> Result.withDefault adInput

        EndDate ->
            Date.fromIsoString value
                |> Result.map (\date -> { adInput | startDate = Just date })
                |> Result.withDefault adInput

        MinAge ->
            { adInput | minAge = value |> String.toInt }

        MaxAge ->
            { adInput | maxAge = value |> String.toInt }
