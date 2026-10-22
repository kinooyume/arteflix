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
  let (imageStatus, onImageLoad, onImageError) = UseImage.useImage(src)

  <div className={Style.container}>
    {switch (imageStatus, renderImage) {
    | (Failed, _) => React.null
    | (_, Some(render)) => render(~src, ~alt, ~className=Style.image, ~onLoad=() => onImageLoad(0))
    | (_, None) =>
      <img
        onLoad={e => onImageLoad((e->JsxEvent.Image.target->Obj.magic)["naturalWidth"])}
        onError={_ => onImageError()}
        className={Style.image}
        src
        ?srcSet
        ?sizes
        alt
      />
    }}
    {switch hover {
    | true => <CardOverlayPlay />
    | false => React.null
    }}
  </div>
}
