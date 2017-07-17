module Component.Home.View exposing (..)

-- Library Imports
import Bootstrap.Carousel as Carousel
import Bootstrap.Carousel.Slide as Slide
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Html exposing (..)
import Html.Attributes exposing(..)

-- Local Imports
import Assets
import Msg
import Component.Home.Model exposing(Model)

slideAttrs : List (Attribute msg)
slideAttrs =
    [ style [ ("width", "960px"), ("height", "540px") ] ]

view : Model -> Html Msg.Msg
view model =
    Grid.container [ class "justify-content-md-center" ]
        [ Grid.row
            [ Row.centerXs ]
            [ Grid.col
                [ Col.middleXs
                , Col.xs8
                , Col.attrs [ style [ ( "text-align", "center" ) ] ] ]
                [ carousel model ]
            ]
        ]

carousel : Model -> Html Msg.Msg
carousel model =
    Carousel.config Msg.CarouselMsg []
        |> Carousel.withControls
        |> Carousel.withIndicators
        |> Carousel.slides
            [ Slide.config [] (Slide.image slideAttrs (Assets.path <| Assets.kitten1))
                |> Slide.caption []
                    [ h4 [] [ text "Slide 1 label"]
                    , p [] [ text "Subtitle for slide 1"]
                    ]
            , Slide.config [] (Slide.image slideAttrs (Assets.path <| Assets.kitten2))
                |> Slide.caption []
                    [ h4 [] [ text "Slide 2 label"]
                    , p [] [ text "Subtitle for slide 2"]
                    ]
            , Slide.config [] (Slide.image slideAttrs (Assets.path <| Assets.kitten3))
                |> Slide.caption []
                    [ h4 [] [ text "Slide 3 label"]
                    , p [] [ text "Subtitle for slide 3"]
                    ]
            , Slide.config [] (Slide.image slideAttrs (Assets.path <| Assets.kitten4))
                |> Slide.caption []
                    [ h4 [] [ text "Slide 4 label"]
                    , p [] [ text "Subtitle for slide 4"]
                    ]
            , Slide.config [] (Slide.image slideAttrs (Assets.path <| Assets.kitten5))
                |> Slide.caption []
                    [ h4 [] [ text "Slide 5 label"]
                    , p [] [ text "Subtitle for slide 5"]
                    ]
            ]
        |> Carousel.view model
