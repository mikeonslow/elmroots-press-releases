module PressReleases exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json
import Json.Decode.Pipeline exposing (decode, required, optional)
import Task


-- MODEL


type alias Model =
    { articles : List Article }


type alias Article =
    { title : String, body : String, link : String }


init : ( Model, Cmd Msg )
init =
    ( Model []
    , getArticles
    )



-- UPDATE


type Msg
    = FetchSucceed Model
    | FetchFail Http.Error


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        FetchSucceed model ->
            ( model, Cmd.none )

        FetchFail _ ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    let
        pressReleaseList =
            List.map pressRelease model.articles
    in
        div []
            pressReleaseList


pressRelease : Article -> Html a
pressRelease article =
    div [ class "row" ]
        [ div [ class "col-md-12" ]
            [ p []
                []
            , h3 []
                [ text article.title ]
            , text article.body
            , p []
                []
            , p []
                [ text "Read more: "
                , a [ href article.link, target "_blank" ]
                    [ text article.link ]
                ]
            ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getArticles : Cmd Msg
getArticles =
    let
        url =
            "/press"
    in
        Task.perform FetchFail FetchSucceed (Http.get articlesDecoder url)


articlesDecoder : Json.Decoder (Model)
articlesDecoder =
    articleDecoder
        |> Json.list
        |> Json.map Model


articleDecoder : Json.Decoder Article
articleDecoder =
    decode Article
        |> Json.Decode.Pipeline.required "title" Json.string
        |> Json.Decode.Pipeline.required "body" Json.string
        |> optional "link" Json.string ""



main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
