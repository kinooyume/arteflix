open ReactAria
open Emotion

// NOTE: ce qui peut se passer
// C'est de passer en mode width/height 100%
// ||> et d'avoir un wrapper
// comme, on memoise le component
//
// Bon ok y'a pas d'urgence

module Style = {
  let base =
    ReactDOM.Style.make(
      ~padding="0",
      ~border="none",
      ~outline="none",
      ~display="block",
      ~backgroundSize="cover",
      ~backgroundPosition="center",
      ~color=Colors.primaryBlack,
      ~position="relative",
      (),
    )->css

  let imageContainer = `position: relative; width: 100%; height: 100%; overflow: hidden; border-radius: 2px;`->rawCss

  let imageBase = ReactDOM.Style.make(~width="100%", ~height="100%", ())->css
  let imageLoaded = cx([
    imageBase,
    `opacity: 1; transition: opacity 0.2s ease, transform 0.15s ease-out;`->rawCss,
  ])
  let imageUnloaded = cx([
    imageBase,
    `opacity: 0; transition: opacity 0.2s ease, transform 0.15s ease-out;`->rawCss,
  ])
  let image = (~loaded) => loaded ? imageLoaded : imageUnloaded

  let shimmerOverlay =
    `position: absolute; top: 0; left: 0; width: 100%; height: 100%; border-radius: 2px;`->rawCss

  let overlay = (~loaded) =>
    `opacity: ${loaded ? "1" : "0"}; transition: opacity 0.2s ease;`->rawCss
  let vertical = `width: 100%; aspect-ratio: 2 / 3;`->rawCss

  let horizontal = `width: 100%; aspect-ratio: 16 / 9;`->rawCss

  let background = (~url) => ReactDOM.Style.make(~backgroundImage="url(" ++ url ++ ")", ())->css
}

type orientation = Horizontal | Vertical

let otherHorizon = "265x149"

let sizeByOrientation = orientation =>
  switch orientation {
  | Horizontal => "336x189"
  | Vertical => "265x397"
  }

let ensureTypeText = src =>
  switch src->String.includes("?type=TEXT") {
  | true => src
  | false => src ++ "?type=TEXT"
  }

type renderImage = (
  ~src: string,
  ~alt: string,
  ~className: string=?,
  ~onLoad: unit => unit=?,
) => React.element

type t = {
  id: string,
  srcBase: string,
  alt: string,
  href: string,
  orientation: orientation,
  duration: option<int>,
  durationLabel: option<string>,
  title: string,
  kindLabel: option<string>,
  forceLabel: option<string>,
}

type props_ = {
  ...t,
  ensureText?: bool,
  onHoverStart?: HoverEvent.t => unit,
  children?: React.element,
  renderImage?: renderImage,
}

@react.component(: props_)
let make = React.memo((
  ~srcBase,
  ~alt,
  ~href,
  ~ensureText=true,
  ~children=?,
  ~onHoverStart=_ => (),
  ~renderImage=?,
) => {
  let orientationStyle = Style.horizontal
  let defaultStyle = cx([Style.base, orientationStyle])
  let onHover = cx([
    defaultStyle,
    `cursor: pointer; img { transform: scale(1.05); }`->rawCss,
  ])

  let srcSized = srcBase->String.replace("__SIZE__", "620x350")
  let src = switch ensureText {
  | true => srcSized->ensureTypeText
  | false => srcSized
  }

  let (loaded, setLoaded) = React.useState(() => false)
  let (retrySrc, onRetryError) = UseRetryImage.useRetryImage(~src)

  let className: Link.classNameFn = ({isHovered}) => isHovered ? onHover : defaultStyle
  <Link className={Fn(className)} href>
    <div className={Style.imageContainer}>
      {loaded ? React.null : <Shimmer width="100%" height="100%" className={Style.shimmerOverlay} />}
      {switch renderImage {
      | Some(render) =>
        render(
          ~src=retrySrc,
          ~alt,
          ~className=Style.image(~loaded),
          ~onLoad=() => setLoaded(_ => true),
        )
      | None =>
        <img
          loading=#"lazy"
          onLoad={_ => setLoaded(_ => true)}
          onError=onRetryError
          className={Style.image(~loaded)}
          src=retrySrc
          alt
        />
      }}
    </div>
    <div className={Style.overlay(~loaded)}>
      {switch children {
      | Some(children) => children
      | None => React.null
      }}
    </div>
  </Link>
})
