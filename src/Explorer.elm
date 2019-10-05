module Explorer exposing (main)

import Form
import Model exposing (Msg)
import UIExplorer exposing (UIExplorerProgram, defaultConfig, explore, storiesOf)


main : UIExplorerProgram {} Msg {}
main =
    explore
        defaultConfig
        [ storiesOf
            "Form"
            [ ( "Default", \_ -> Form.view, {} )
            ]
        ]
