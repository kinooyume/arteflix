open Emotion
open ReactAria

module Style = {
  let container = `
    width: 100%;
    height: 100%;
    flex-shrink: 0;
    background-color: lightgray;
    border-radius: 4px 4px 0 0;
    outline: none;
    overflow: hidden;
  `->rawCss

  let img = `
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
    display: block;
  `->rawCss
}

type renderImage = (
  ~src: string,
  ~alt: string,
  ~className: string=?,
  ~onLoad: unit => unit=?,
  ~onError: unit => unit=?,
) => React.element

type previewImageProps = {
  srcBase: string,
  href: string,
  renderImage?: renderImage,
}

@react.component(: previewImageProps)
let make = (~srcBase, ~href, ~renderImage=?) => {
  let src = srcBase->String.replace("__SIZE__", "620x350")
  let (imageStatus, onImageLoad, onImageError) = UseImage.useImage(src)

  <Link href>
    <div className={Style.container}>
      {switch (imageStatus, renderImage) {
      | (Failed, _) => React.null
      | (_, Some(render)) =>
        render(~src, ~alt="", ~className=Style.img, ~onLoad=() => onImageLoad(0), ~onError=onImageError)
      | (_, None) =>
        <img
          className={Style.img}
          src
          alt=""
          onLoad={e => onImageLoad((e->JsxEvent.Image.target->Obj.magic)["naturalWidth"])}
          onError={_ => onImageError()}
        />
      }}
    </div>
  </Link>
}
