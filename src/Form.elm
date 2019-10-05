module Form exposing (updateAdInputByField, view)

import Date
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Model exposing (..)


viewFieldRow children =
    div [ class "flex m-2" ]
        children


customInput inputType placeholderText toMsg =
    let
        inputClass =
            "font-sans p-1 w-64 shadow appearance-none border rounded  py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
    in
    input [ onInput toMsg, type_ inputType, placeholder placeholderText, class inputClass ] []


customButton =
    let
        buttonClass =
            "font-sans bg-orange-400 hover:bg-orange-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
    in
    button [ class buttonClass ] [ text "Générer une annonce" ]


customTitle titleText =
    span [ class "text-xl ml-2 font-sans text-gray-600" ] [ text titleText ]


view : Html Msg
view =
    Html.form [ class "flex h-screen w-screen flex-col p-3", style "width" "600px" ]
        [ div [ class "mb-4" ]
            [ customTitle "Durée du séjour"
            , viewFieldRow
                [ div [ class "mr-2" ] [ customInput "date" "start date" (ChangeField StartDate) ]
                , div [] [ customInput "date" "end date" (ChangeField EndDate) ]
                ]
            ]
        , div
            []
            [ customTitle "Tranche d'age"
            , viewFieldRow
                [ div [ class "mr-2" ] [ customInput "number" "min age" (ChangeField MinAge) ]
                , div [] [ customInput "number" "max age" (ChangeField MaxAge) ]
                ]
            ]
        , viewFieldRow [ div [ class "float-right mt-4" ] [ customButton ] ]
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
