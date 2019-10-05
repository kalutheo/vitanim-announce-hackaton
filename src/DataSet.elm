module DataSet exposing (testAdListing)

import CustomTable.CustomTable as CustomTable
import Date exposing (Date)
import Model exposing (..)
import Time exposing (Month(..))


testAdListing =
    { state = CustomTable.initState -1
    , data =
        [ { index = 0
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 1
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 2
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 3
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 4
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 5
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 6
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 7
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 8
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 9
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 10
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 11
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 12
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 13
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 14
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 15
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 16
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 17
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        , { index = 18
          , selected = False
          , startDate = Date.fromCalendarDate 2018 Sep 26
          , endDate = Date.fromCalendarDate 2018 Sep 27
          , minAge = 6
          , maxAge = 7
          , thematic = Funky
          }
        ]
    }
