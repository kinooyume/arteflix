open ReactAria
open Emotion

module Picture = {
  module Style = {
    let size = `
      width: var(--episode-card-width);
      aspect-ratio: 128 / 72;
      border-radius: 2px;
    `->rawCss

    let container = [ReactDOM.Style.make(~position="relative", ())->css, size]->cx
  }

  type props_ = {src: string, alt: string}

  @react.component(: props_)
  let make = (~src, ~alt) => {
    <div className={Style.container}>
      <img className={Style.size} src alt />
      <CardOverlayPlay />
    </div>
  }
}

module Bullet = {
  let style =
    ReactDOM.Style.make(
      ~display="flex",
      ~width="51px",
      ~height="29px",
      ~flexDirection="column",
      ~justifyContent="center",
      ~flexBasis="51px",
      ~flexGrow="0",
      ~flexShrink="0",
      (),
    )->css

  type props_ = {index: int}

  open Text
  @react.component(: props_)
  let make = (~index) => {
    <div className={style}>
      <Regular.Title2> {index->React.int} </Regular.Title2>
    </div>
  }
}

module Style = {
  let default =
    ReactDOM.Style.make(
      ~display="flex",
      ~outline="none !important",
      ~flexDirection="row",
      ~textDecoration="none",
      ~alignItems="center",
      ~padding="16px clamp(16px, 0.5rem + 2.5vw, 52px) 16px 16px",
      ~transition="all 0.2s ease-out",
      ~borderRadius=" 4px",
      ~borderBottom=`1px solid ${Colors.greyGrey_450}`,
      ~borderTop=`1px solid transparent`,
      (),
    )->css
  let selected =
    [
      default,
      ReactDOM.Style.make(
        ~backgroundColor=Colors.greyGrey_600,
        ~borderTop=`1px solid ${Colors.greyGrey_450}`,
        (),
      )->css,
    ]->cx

  let content =
    ReactDOM.Style.make(
      ~display="flex",
      ~flexDirection="row",
      ~alignItems="center",
      ~width="100%",
      (),
    )->css
}

type t = {
  href: string,
  title: string,
  id: string,
  description: option<string>,
  duration: option<string>,
  imageSrc: string,
  imageSrcSet?: string,
  imageAlt: string,
  selected: bool,
}

type props_ = {
  ...t,
  index: int,
  renderImage?: EpisodeCard.renderImage,
}

@react.component(: props_)
let make = (
  ~index,
  ~href,
  ~title,
  ~description,
  ~duration,
  ~imageSrc,
  ~imageSrcSet=?,
  ~imageAlt,
  ~selected,
  ~renderImage=?,
) => {
  let (hover, setHover) = React.useState(() => false)
  let srcSet = imageSrcSet

  let className = switch selected {
  | true => [Style.default, Style.selected]->cx
  | false => Style.default
  }

  <Link className={String(className)} onHoverChange={isHovering => setHover(_ => isHovering)} href>
    <Bullet index />
    <div className={Style.content}>
      <EpisodeCard src=imageSrc ?srcSet sizes="15vw" alt=imageAlt hover ?renderImage />
      <EpisodeButtonContent title description duration />
    </div>
  </Link>
}
