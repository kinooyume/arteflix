open Emotion

module Style = {
  let container = `
    width: 100%;
    position: relative;
    max-height: calc(var(--hero-height) - 48px);
    overflow: hidden;
    flex-shrink: 0;
  `->rawCss

  let containerOverflow = ReactDOM.Style.make(~maxHeight="calc(100vh - 202px)", ())->css

  let img = `
    display: block;
    width: 100%;
    height: auto;
    ${Responsive.mobileDown} {
      position: absolute;
      top: 0;
      left: 0;
      height: 100%;
      object-fit: cover;
    }
  `->rawCss

  let gradient = `
    position: absolute;
    left: 0;
    right: 0;
    bottom: 0;
    width: 100%;
    height: 70%;
    background: linear-gradient(to top, rgb(20, 20, 20), rgba(0, 0, 0, 0));
  `->rawCss

  let fullHeight = ReactDOM.Style.make(~height="100%", ())->css

  let content = `
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 0 var(--side-padding);
    margin-bottom: clamp(24px, 1rem + 1.5vw, 48px);
  `->rawCss

  let contentExtraMargin = `
    margin-bottom: clamp(60px, 3rem + 2.5vw, 100px);
    ${Responsive.mobileDown} {
      margin-bottom: 24px;
    }
  `->rawCss

  let mobileHero = `
    ${Responsive.mobileDown} {
      --hero-height: 50vh;
      min-height: 90vw;
      overflow: visible;
    }
  `->rawCss
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
  overflow?: bool,
  children: React.element,
  renderImage?: renderImage,
}

@react.component(: props_)
let make = (~src, ~srcSet=?, ~sizes=?, ~alt, ~children, ~overflow=false, ~renderImage=?) => {
  let (containerStyle, contentStyle, imgStyle, gradientStyle) = switch overflow {
  | true => (
      [Style.container, Style.containerOverflow, Style.mobileHero]->cx,
      [Style.content, Style.contentExtraMargin]->cx,
      Style.img,
      [Style.gradient, Style.fullHeight]->cx,
    )
  | false => (
      [Style.container, Style.mobileHero]->cx,
      Style.content,
      Style.img,
      Style.gradient,
    )
  }
  <section className={containerStyle}>
    {switch renderImage {
    | Some(render) => render(~src, ~alt, ~className=imgStyle)
    | None =>
      ReactDOM.createElement(
        "img",
        ~props=Obj.magic({"className": imgStyle, "src": src, "srcSet": srcSet, "sizes": sizes, "alt": alt, "fetchPriority": "high"}),
        [],
      )
    }}
    <div className={gradientStyle} />
    <div className={contentStyle}> children </div>
  </section>
}
