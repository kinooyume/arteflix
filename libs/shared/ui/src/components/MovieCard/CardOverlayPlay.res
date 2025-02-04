open Emotion

module Style = {
  let container =
    ReactDOM.Style.make(
      ~display="flex",
      ~alignItems="center",
      ~justifyContent="center",
      ~width="100%",
      ~height="100%",
      ~position="absolute",
      ~top="0",
      ~bottom="0",
      ~left="0",
      ~right="0",
      ~backgroundColor=Colors.transparentWhite_15,
      (),
    )->css
}

@react.component
let make = () =>
  <div className={Style.container}>
    <Svg.OverlayPlay />
  </div>
