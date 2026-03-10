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
  ~onLoad: unit => unit=?,
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
  let (assetStatus, assetOnLoad, assetOnError) = UseAsset.useAsset(~url=src, ~priority=Low)

  <div className={Style.container}>
    {switch assetStatus {
    | Pending | Failed => React.null
    | Ready(readyUrl) =>
      switch renderImage {
      | Some(render) => render(~src=readyUrl, ~alt, ~className=Style.image, ~onLoad=assetOnLoad)
      | None =>
        <img
          onLoad={_ => assetOnLoad()}
          onError={_ => assetOnError()}
          className={Style.image}
          src=readyUrl
          ?srcSet
          ?sizes
          alt
        />
      }
    }}
    {switch hover {
    | true => <CardOverlayPlay />
    | false => React.null
    }}
  </div>
}
