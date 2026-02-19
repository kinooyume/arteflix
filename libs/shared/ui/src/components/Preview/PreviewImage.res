open Emotion
open ReactAria

let bgStyle = imagePath =>
  ReactDOM.Style.make(
    ~display="flex",
    ~width="100%",
    ~height="100%",
    ~flexShrink="0",
    ~backgroundImage=`url(${imagePath})`,
    ~backgroundColor="lightgray",
    ~backgroundSize="cover",
    ~backgroundPosition="50%",
    ~backgroundRepeat="no-repeat",
    ~borderRadius="4px 4px 0 0",
    ~outline="none",
    (),
  )->css

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

type renderImage = (~src: string, ~alt: string, ~className: string=?) => React.element

type previewImageProps = {
  srcBase: string,
  href: string,
  renderImage?: renderImage,
}

@react.component(: previewImageProps)
let make = (~srcBase, ~href, ~renderImage=?) => {
  let src = srcBase->String.replace("__SIZE__", "620x350")
  <Link href>
    {switch renderImage {
    | Some(render) =>
      <div className={Style.container}>
        {render(~src, ~alt="", ~className=Style.img)}
      </div>
    | None =>
      <div className={bgStyle(src)} />
    }}
  </Link>
}
