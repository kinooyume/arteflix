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
  let (assetStatus, assetOnLoad, assetOnError) = UseAsset.useAsset(~url=src, ~priority=Medium)

  <Link href>
    {switch assetStatus {
    | Pending | Failed => <div className={Style.container} />
    | Ready(readyUrl) =>
      <div className={Style.container}>
        {switch renderImage {
        | Some(render) =>
          render(
            ~src=readyUrl,
            ~alt="",
            ~className=Style.img,
            ~onLoad=() => assetOnLoad(0),
            ~onError=assetOnError,
          )
        | None =>
          <img
            className={Style.img}
            src=readyUrl
            alt=""
            onLoad={_ => assetOnLoad(0)}
            onError={_ => assetOnError()}
          />
        }}
      </div>
    }}
  </Link>
}
