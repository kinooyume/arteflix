open Emotion

module Style = {
  let size =
    ReactDOM.Style.make(
      ~width="128px",
      ~height="72px",
      ~flexBasis="128px",
      ~flexGrow="0",
      ~flexShrink="0",
      ~borderRadius="2px",
      (),
    )->css

  let container = [ReactDOM.Style.make(~position="relative", ())->css, size]->cx

  let image = [ReactDOM.Style.make()->css, size]->cx
}

type props_ = {
  src: string,
  alt: string,
  hover?: bool,
}

@react.component(: props_)
let make = (~src, ~alt, ~hover=false) => {
  <div className={Style.container}>
    <img loading=#"lazy" className={Style.image} src alt />
    {switch hover {
    | true => <CardOverlayPlay />
    | false => React.null
    }}
  </div>
}
