open Emotion

type t

let primaryBlack = "rgb(0, 0, 0)"
let primaryRed = "rgb(229, 9, 20)"
let primaryWhite = "rgb(255, 255, 255)"
let secondaryRed_100 = "rgb(235, 57, 66)"
let secondaryRed_200 = "rgb(193, 17, 25)"
let secondaryRed_300 = "rgb(245, 7, 35)"
let secondaryBlue_100 = "rgb(0, 113, 235)"
let secondaryBlue_200 = "rgb(68, 142, 244)"
let secondaryBlue_300 = "rgb(84, 185, 197)"
let secondaryGreen = "rgb(70, 211, 105)"
let greyGrey_10 = "rgb(229, 229, 229)"
let greyGrey_20 = "rgb(220, 220, 220)"
let greyGrey_25 = "rgb(210, 210, 210)"
let greyGrey_50 = "rgb(188, 188, 188)"
let greyGrey_100 = "rgb(179, 179, 179)"
let greyGrey_150 = "rgb(151, 151, 151)"
let greyGrey_200 = "rgb(128, 128, 128)"
let greyGrey_250 = "rgb(119, 119, 119)"
let greyGrey_300T70 = "rgba(109, 109, 110, 0.7)"
let greyGrey_300T40 = "rgba(109, 109, 110, 0.4)"
let greyGrey_350 = "rgb(84, 84, 84)"
let greyGrey_400 = "rgb(65, 65, 65)"
let greyGrey_450 = "rgb(64, 64, 64)"
let greyGrey_500 = "rgb(58, 58, 58)"
let greyGrey_550 = "rgb(54, 54, 54)"
let greyGrey_600 = "rgb(51, 51, 51)"
let greyGrey_600T60 = "rgba(51, 51, 51, 0.6)"
let greyGrey_650 = "rgb(47, 47, 47)"
let greyGrey_700 = "rgb(42, 42, 42)"
let greyGrey_750 = "rgb(38, 38, 38)"
let greyGrey_800 = "rgb(35, 35, 35)"
let greyGrey_850 = "rgb(24, 24, 24)"
let greyGrey_900 = "rgb(20, 20, 20)"
let transparentWhite_15 = "rgba(255, 255, 255, 0.15)"
let transparentWhite_20 = "rgba(255, 255, 255, 0.2)"
let transparentWhite_30 = "rgba(255, 255, 255, 0.3)"
let transparentWhite_35 = "rgba(255, 255, 255, 0.35)"
let transparentWhite_50 = "rgba(255, 255, 255, 0.5)"
let transparentWhite_70 = "rgba(255, 255, 255, 0.7)"
let transparentBlack_30 = "rgba(0, 0, 0, 0.3)"
let transparentBlack_90 = "rgba(0, 0, 0, 0.9)"
let transparentBlack_60 = "rgba(0, 0, 0, 0.6)"

module Text = {
  let primaryBlack = ReactDOM.Style.make(~color=primaryBlack, ())->css
  let primaryRed = ReactDOM.Style.make(~color=primaryRed, ())->css
  let primaryWhite = ReactDOM.Style.make(~color=primaryWhite, ())->css
  let secondaryRed_100 = ReactDOM.Style.make(~color=secondaryRed_100, ())->css
  let secondaryRed_200 = ReactDOM.Style.make(~color=secondaryRed_200, ())->css
  let secondaryRed_300 = ReactDOM.Style.make(~color=secondaryRed_300, ())->css
  let secondaryBlue_100 = ReactDOM.Style.make(~color=secondaryBlue_100, ())->css
  let secondaryBlue_200 = ReactDOM.Style.make(~color=secondaryBlue_200, ())->css
  let secondaryBlue_300 = ReactDOM.Style.make(~color=secondaryBlue_300, ())->css
  let secondaryGreen = ReactDOM.Style.make(~color=secondaryGreen, ())->css
  let greyGrey_10 = ReactDOM.Style.make(~color=greyGrey_10, ())->css
  let greyGrey_20 = ReactDOM.Style.make(~color=greyGrey_20, ())->css
  let greyGrey_25 = ReactDOM.Style.make(~color=greyGrey_25, ())->css
  let greyGrey_50 = ReactDOM.Style.make(~color=greyGrey_50, ())->css
  let greyGrey_100 = ReactDOM.Style.make(~color=greyGrey_100, ())->css
  let greyGrey_150 = ReactDOM.Style.make(~color=greyGrey_150, ())->css
  let greyGrey_200 = ReactDOM.Style.make(~color=greyGrey_200, ())->css
  let greyGrey_250 = ReactDOM.Style.make(~color=greyGrey_250, ())->css
  let greyGrey_300T70 = ReactDOM.Style.make(~color=greyGrey_300T70, ())->css
  let greyGrey_300T40 = ReactDOM.Style.make(~color=greyGrey_300T40, ())->css
  let greyGrey_350 = ReactDOM.Style.make(~color=greyGrey_350, ())->css
  let greyGrey_400 = ReactDOM.Style.make(~color=greyGrey_400, ())->css
  let greyGrey_450 = ReactDOM.Style.make(~color=greyGrey_450, ())->css
  let greyGrey_500 = ReactDOM.Style.make(~color=greyGrey_500, ())->css
  let greyGrey_550 = ReactDOM.Style.make(~color=greyGrey_550, ())->css
  let greyGrey_600 = ReactDOM.Style.make(~color=greyGrey_600, ())->css
  let greyGrey_600T60 = ReactDOM.Style.make(~color=greyGrey_600T60, ())->css
  let greyGrey_650 = ReactDOM.Style.make(~color=greyGrey_650, ())->css
  let greyGrey_700 = ReactDOM.Style.make(~color=greyGrey_700, ())->css
  let greyGrey_750 = ReactDOM.Style.make(~color=greyGrey_750, ())->css
  let greyGrey_800 = ReactDOM.Style.make(~color=greyGrey_800, ())->css
  let greyGrey_850 = ReactDOM.Style.make(~color=greyGrey_850, ())->css
  let greyGrey_900 = ReactDOM.Style.make(~color=greyGrey_900, ())->css
  let transparentWhite_15 = ReactDOM.Style.make(~color=transparentWhite_15, ())->css
  let transparentWhite_20 = ReactDOM.Style.make(~color=transparentWhite_20, ())->css
  let transparentWhite_30 = ReactDOM.Style.make(~color=transparentWhite_30, ())->css
  let transparentWhite_35 = ReactDOM.Style.make(~color=transparentWhite_35, ())->css
  let transparentWhite_50 = ReactDOM.Style.make(~color=transparentWhite_50, ())->css
  let transparentWhite_70 = ReactDOM.Style.make(~color=transparentWhite_70, ())->css
  let transparentBlack_30 = ReactDOM.Style.make(~color=transparentBlack_30, ())->css
  let transparentBlack_90 = ReactDOM.Style.make(~color=transparentBlack_90, ())->css
  let transparentBlack_60 = ReactDOM.Style.make(~color=transparentBlack_60, ())->css
}

module Background = {
  let primaryBlack = ReactDOM.Style.make(~backgroundColor=primaryBlack, ())->css
  let primaryRed = ReactDOM.Style.make(~backgroundColor=primaryRed, ())->css
  let primaryWhite = ReactDOM.Style.make(~backgroundColor=primaryWhite, ())->css
  let secondaryRed_100 = ReactDOM.Style.make(~backgroundColor=secondaryRed_100, ())->css
  let secondaryRed_200 = ReactDOM.Style.make(~backgroundColor=secondaryRed_200, ())->css
  let secondaryRed_300 = ReactDOM.Style.make(~backgroundColor=secondaryRed_300, ())->css
  let secondaryBlue_100 = ReactDOM.Style.make(~backgroundColor=secondaryBlue_100, ())->css
  let secondaryBlue_200 = ReactDOM.Style.make(~backgroundColor=secondaryBlue_200, ())->css
  let secondaryBlue_300 = ReactDOM.Style.make(~backgroundColor=secondaryBlue_300, ())->css
  let secondaryGreen = ReactDOM.Style.make(~backgroundColor=secondaryGreen, ())->css
  let greyGrey_10 = ReactDOM.Style.make(~backgroundColor=greyGrey_10, ())->css
  let greyGrey_20 = ReactDOM.Style.make(~backgroundColor=greyGrey_20, ())->css
  let greyGrey_25 = ReactDOM.Style.make(~backgroundColor=greyGrey_25, ())->css
  let greyGrey_50 = ReactDOM.Style.make(~backgroundColor=greyGrey_50, ())->css
  let greyGrey_100 = ReactDOM.Style.make(~backgroundColor=greyGrey_100, ())->css
  let greyGrey_150 = ReactDOM.Style.make(~backgroundColor=greyGrey_150, ())->css
  let greyGrey_200 = ReactDOM.Style.make(~backgroundColor=greyGrey_200, ())->css
  let greyGrey_250 = ReactDOM.Style.make(~backgroundColor=greyGrey_250, ())->css
  let greyGrey_300T70 = ReactDOM.Style.make(~backgroundColor=greyGrey_300T70, ())->css
  let greyGrey_300T40 = ReactDOM.Style.make(~backgroundColor=greyGrey_300T40, ())->css
  let greyGrey_350 = ReactDOM.Style.make(~backgroundColor=greyGrey_350, ())->css
  let greyGrey_400 = ReactDOM.Style.make(~backgroundColor=greyGrey_400, ())->css
  let greyGrey_450 = ReactDOM.Style.make(~backgroundColor=greyGrey_450, ())->css
  let greyGrey_500 = ReactDOM.Style.make(~backgroundColor=greyGrey_500, ())->css
  let greyGrey_550 = ReactDOM.Style.make(~backgroundColor=greyGrey_550, ())->css
  let greyGrey_600 = ReactDOM.Style.make(~backgroundColor=greyGrey_600, ())->css
  let greyGrey_600T60 = ReactDOM.Style.make(~backgroundColor=greyGrey_600T60, ())->css
  let greyGrey_650 = ReactDOM.Style.make(~backgroundColor=greyGrey_650, ())->css
  let greyGrey_700 = ReactDOM.Style.make(~backgroundColor=greyGrey_700, ())->css
  let greyGrey_750 = ReactDOM.Style.make(~backgroundColor=greyGrey_750, ())->css
  let greyGrey_800 = ReactDOM.Style.make(~backgroundColor=greyGrey_800, ())->css
  let greyGrey_850 = ReactDOM.Style.make(~backgroundColor=greyGrey_850, ())->css
  let greyGrey_900 = ReactDOM.Style.make(~backgroundColor=greyGrey_900, ())->css
  let transparentWhite_15 = ReactDOM.Style.make(~backgroundColor=transparentWhite_15, ())->css
  let transparentWhite_20 = ReactDOM.Style.make(~backgroundColor=transparentWhite_20, ())->css
  let transparentWhite_30 = ReactDOM.Style.make(~backgroundColor=transparentWhite_30, ())->css
  let transparentWhite_35 = ReactDOM.Style.make(~backgroundColor=transparentWhite_35, ())->css
  let transparentWhite_50 = ReactDOM.Style.make(~backgroundColor=transparentWhite_50, ())->css
  let transparentWhite_70 = ReactDOM.Style.make(~backgroundColor=transparentWhite_70, ())->css
  let transparentBlack_30 = ReactDOM.Style.make(~backgroundColor=transparentBlack_30, ())->css
  let transparentBlack_90 = ReactDOM.Style.make(~backgroundColor=transparentBlack_90, ())->css
  let transparentBlack_60 = ReactDOM.Style.make(~backgroundColor=transparentBlack_60, ())->css
}
