open Emotion

module Style = {
  let size = `
    width: var(--episode-card-width);
    aspect-ratio: 128 / 72;
    flex-shrink: 0;
    border-radius: 2px;
  `->rawCss

  let container = [ReactDOM.Style.make(~position="relative", ())->css, size]->cx

  let image = [ReactDOM.Style.make(~height="auto", ())->css, size]->cx
}

type renderImage = (
  ~src: string,
  ~alt: string,
  ~className: string=?,
) => React.element

type props_ = {
  src: string,
  srcSet?: string,
  sizes?: string,
  alt: string,
  hover?: bool,
  renderImage?: renderImage,
}

@react.component(: props_)
let make = (~src, ~srcSet=?, ~sizes=?, ~alt, ~hover=false, ~renderImage=?) => {
  let (retrySrc, onRetryError) = UseRetryImage.useRetryImage(~src)

  <div className={Style.container}>
    {switch renderImage {
    | Some(render) => render(~src=retrySrc, ~alt, ~className=Style.image)
    | None => <img loading=#"lazy" onError=onRetryError className={Style.image} src=retrySrc ?srcSet ?sizes alt />
    }}
    {switch hover {
    | true => <CardOverlayPlay />
    | false => React.null
    }}
  </div>
}
