module PressReleases exposing (..)

import Json.Decode as Json
import Json.Decode.Pipeline exposing (decode, required, optional)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Task



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = \_ -> Sub.none
    }


init : (Model, Cmd Msg)
init =
  (Model articleList, Cmd.none)


-- MODEL


type alias Model =
  {
    articles : Articles
  }


type alias Articles = List Article


type alias Article =
  { title : String
  , body : String
  , link : String
  }


initialModel : Model
initialModel =
  { articles = articleList }


articleList : List Article
articleList = [
  {
    title = "Crain’s Communications Awards Clarity Voice as Coolest Places to Work in Michigan",
    body = "",
    link = "http://www.crainsdetroit.com/awards/cool_places_to_work/2014"
  },
  {
    title = "Clarity Voice Recognized as Top 50 Companies to Watch in Michigan at 2016 Award Event.",
    body = "",
    link = "https://www.michigancelebrates.biz/the-event/2016-award-winners/"
  },
  {
    title = "Clarity Voice Ranked #19 Top Detroit Companies by INC.",
    body = "",
    link = "http://www.inc.com/profile/clarity-voice"
  }]



-- UPDATE

type Msg = NoOp

update : Msg -> Model -> Model
update msg model =
  case msg of
    _ -> (Model model, Cmd.none)


-- VIEW

view : Model -> Html Msg
view model =
  div [] [ text "Test" ]

