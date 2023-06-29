module Main exposing (main)

import Browser
import Browser.Events exposing (onAnimationFrameDelta)
import Canvas exposing (..)
import Canvas.Settings exposing (..)
import Canvas.Settings.Advanced exposing (..)
import Color
import Html exposing (Html)


type alias Dimensions =
    { width : Float, height : Float }


type alias Context =
    { count : Float, width : Float, height : Float }


type Msg
    = Frame Float


main : Program Dimensions Context Msg
main =
    Browser.element
        { init =
            \{ width, height } ->
                ( { width = width
                  , height = height
                  , count = 0
                  }
                , Cmd.none
                )
        , view = view
        , update =
            \msg context ->
                case msg of
                    Frame _ ->
                        ( { context | count = context.count + 1 }, Cmd.none )
        , subscriptions = \_ -> onAnimationFrameDelta Frame
        }


view : Context -> Html Msg
view ({ width, height } as context) =
    Canvas.toHtml
        ( round width, round height )
        []
        [ clearScreen context
        , render context
        ]


clearScreen { width, height } =
    shapes [ fill Color.white ] [ rect ( 0, 0 ) width height ]


render { count, width, height } =
    let
        centerX =
            width / 2

        centerY =
            height / 2

        size =
            width / 3

        x =
            -(size / 2)

        y =
            -(size / 2)
    in
    shapes
        [ transform
            [ translate centerX centerY
            , rotate (degrees (count / 3))
            ]
        , fill (Color.hsl (sin <| count / 1000) 0.7 0.7)
        ]
        [ rect ( x, y ) size size ]
