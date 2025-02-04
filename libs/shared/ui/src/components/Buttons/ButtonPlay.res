open Emotion

module Style = {
  let inner = ReactDOM.Style.make(~display="flex", ~alignItems="center", ~gap="12px", ())->css
}
type props_ = {href: string, text: string}

@react.component(: props_)
let make = (~href, ~text) =>
  <Button variant={Button.Secondary} size={Button.Medium} href>
    <div className={Style.inner}>
      <Svg.Triangle />
      {text->React.string}
    </div>
  </Button>
