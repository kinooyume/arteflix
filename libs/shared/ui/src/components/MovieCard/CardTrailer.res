open Emotion

module Style = {
  let container =
    ReactDOM.Style.make(
      ~display="inline-flex",
      ~flexDirection="column",
      ~alignItems="flex-start",
      ~borderRadius=Radius.sm,
      (),
    )->css
}
type props_ = {
  text: string,
  children: React.element,
}

@react.component(: props_)
let make = React.memo((~text, ~children) => {
  <div className={Style.container}>
    children
    <CardOverlayTrailer> {text->React.string} </CardOverlayTrailer>
  </div>
})
