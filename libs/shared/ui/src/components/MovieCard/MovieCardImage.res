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

  let image = ReactDOM.Style.make(~borderRadius="2px", ~width="100%", ~height="100%", ())->css
  let vertical = `width: 100%; aspect-ratio: 2 / 3;`->rawCss

  let horizontal = `width: 100%; aspect-ratio: 16 / 9;`->rawCss

  let background = (~url) => ReactDOM.Style.make(~backgroundImage="url(" ++ url ++ ")", ())->css
}

type orientation = Horizontal | Vertical

let otherHorizon = "265x149"

let sizeByOrientation = orientation =>
  switch orientation {
  | Horizontal => "325x183"
  | Vertical => "265x397"
  }

let ensureTypeText = src =>
  switch src->String.includes("?type=TEXT") {
  | true => src
  | false => src ++ "?type=TEXT"
  }

type t = {
  id: string,
  srcBase: string,
  alt: string,
  href: string,
  orientation: orientation,
  // Overlay. Doesn't belong to Card image but card
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
}

@react.component(: props_)
let make = React.memo((
  ~srcBase,
  ~alt,
  ~href,
  ~ensureText=true,
  ~children=?,
  ~onHoverStart=_ => (),
) => {
  let orientationStyle = Style.horizontal

  // let orientationStyle = switch orientation {
  // | Horizontal => Style.horizontal
  // | Vertical => Style.vertical
  // }
  let defaultStyle = cx([Style.base, orientationStyle])
  let onHover = cx([defaultStyle, ReactDOM.Style.make(~cursor="pointer", ())->css])

  let srcSized = srcBase->String.replace("__SIZE__", "325x183")
  let src = switch ensureText {
  | true => srcSized->ensureTypeText
  | false => srcSized
  }

  let makeSrcSet = base => {
    let size = s => base->String.replace("__SIZE__", s)
    `${size("210x118")} 210w, ${size("400x225")} 400w, ${size("720x406")} 720w`
  }
  let srcSet = makeSrcSet(srcBase)

  let className: Link.classNameFn = ({isHovered}) => isHovered ? onHover : defaultStyle
  <Link className={Fn(className)} href>
    <img
      loading=#"lazy"
      onError={e => {
        open ReactEvent.Media
        target(e)["onerror"] = Js.null
        target(e)["src"] = srcSized
      }}
      className={Style.image}
      src
      srcSet
      sizes="(max-width: 599px) 50vw, (max-width: 899px) 33vw, (max-width: 1099px) 25vw, (max-width: 1399px) 20vw, 17vw"
      alt
    />
    {switch children {
    | Some(children) => children
    | None => React.null
    }}
  </Link>
})
