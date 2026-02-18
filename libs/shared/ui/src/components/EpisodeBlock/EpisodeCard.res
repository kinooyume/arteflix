open Emotion

module Style = {
  let size = `
    width: var(--episode-card-width);
    aspect-ratio: 128 / 72;
    flex-shrink: 0;
    border-radius: 2px;
  `->rawCss

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
