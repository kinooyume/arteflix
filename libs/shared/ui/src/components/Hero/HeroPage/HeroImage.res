open Emotion

// NOTE: idéalement, on sépare container/content (hero home et hero collection)
//
// https://v0.dev/t/cma7x1zObqm
module Style = {
  let container =
    ReactDOM.Style.make(
      ~width="100%",
      ~position="relative",
      ~height="calc(80vh - 48px)",
      ~display="flex",
      ~flexShrink="0",
      ~alignItems="flex-end",
      (),
    )->css

  let containerOverflow = ReactDOM.Style.make(~height="calc(100vh - 202px)", ())->css

  let img =
    ReactDOM.Style.make(
      ~position="absolute",
      ~top="0",
      ~left="0",
      ~right="0",
      ~bottom="0",
      ~width="100%",
      ~height="80vh",
      ~objectFit="cover",
      (),
    )->css

  let fullHeight = ReactDOM.Style.make(~height="100vh", ())->css

  let gradient =
    ReactDOM.Style.make(
      ~position="absolute",
      ~top="0",
      ~left="0",
      ~right="0",
      ~bottom="0",
      ~width="100%",
      ~height="80vh",
      ~background="linear-gradient(to top, rgb(20, 20, 20), rgba(0, 0, 0, 0))",
      (),
    )->css

  let content =
    ReactDOM.Style.make(~position="relative", ~padding="0 58px", ~marginBottom="48px", ())->css

  let contentExtraMargin = ReactDOM.Style.make(~marginBottom="100px", ())->css
}
type props_ = {
  src: string,
  alt: string,
  overflow?: bool,
  children: React.element,
}

@react.component(: props_)
let make = (~src, ~alt, ~children, ~overflow=false) => {
  let (containerStyle, contentStyle, imgStyle, gradientStyle) = switch overflow {
  | true => (
      [Style.container, Style.containerOverflow]->cx,
      [Style.content, Style.contentExtraMargin]->cx,
      [Style.img, Style.fullHeight]->cx,
      [Style.gradient, Style.fullHeight]->cx,
    )
  | false => (Style.container, Style.content, Style.img, Style.gradient)
  }
  <section className={containerStyle}>
    <img className={imgStyle} src={src} alt={alt} />
    <div className={gradientStyle} />
    <div className={contentStyle}> children </div>
  </section>
}
