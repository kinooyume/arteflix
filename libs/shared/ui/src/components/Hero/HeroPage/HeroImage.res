open Emotion

module Style = {
  let container = `
    width: 100%;
    position: relative;
    max-height: calc(var(--hero-height) - 48px);
    overflow: hidden;
    flex-shrink: 0;
  `->rawCss

  let containerFullscreen = `
    display: grid;
    grid-template-rows: minmax(clamp(48px, 2.5rem + 1.3vw, 68px), 1fr) auto minmax(0, 35%);
    height: 56.25vw;
    max-height: calc(100vh - 400px);
    overflow: visible;
  `->rawCss

  let imgWrapper = `
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: min(56.25vw, calc(100vh - 68px));
    overflow: hidden;
    z-index: -1;
    ${Responsive.mobileDown} {
      height: 100%;
    }
  `->rawCss

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

  let imgCover = `
    grid-row: 1 / -1;
    grid-column: 1;
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center top;
  `->rawCss

  let gradientBase = `
    width: 100%;
    height: 14.7vw;
    background: linear-gradient(
      180deg,
      hsla(0, 0%, 8%, 0) 0,
      hsla(0, 0%, 8%, 0.15) 15%,
      hsla(0, 0%, 8%, 0.35) 29%,
      hsla(0, 0%, 8%, 0.58) 44%,
      #141414 68%,
      #141414
    );
  `->rawCss

  let gradientAbsolute = `
    position: absolute;
    left: 0;
    right: 0;
    bottom: -1px;
  `->rawCss

  let gradientGrid = `
    grid-row: 1 / -1;
    grid-column: 1;
    align-self: end;
  `->rawCss

  let lateralVignetteBase = `
    background: linear-gradient(77deg, rgba(0, 0, 0, 0.6), transparent 85%);
  `->rawCss

  let lateralVignetteAbsolute = `
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
  `->rawCss

  let lateralVignetteGrid = `
    grid-row: 1 / -1;
    grid-column: 1;
  `->rawCss

  let content = `
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 0 var(--side-padding);
    margin-bottom: clamp(24px, 1rem + 1.5vw, 48px);
  `->rawCss

  let contentGrid = `
    grid-row: 2;
    grid-column: 1;
    padding: 0 var(--side-padding);
    z-index: 1;
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
  switch overflow {
  | true =>
    <section className={[Style.container, Style.containerFullscreen, Style.mobileHero]->cx}>
      <div className={Style.imgWrapper}>
        {switch renderImage {
        | Some(render) => render(~src, ~alt, ~className=Style.imgCover)
        | None =>
          ReactDOM.createElement(
            "img",
            ~props=Obj.magic({"className": Style.imgCover, "src": src, "srcSet": srcSet, "sizes": sizes, "alt": alt, "fetchPriority": "high"}),
            [],
          )
        }}
        <div className={[Style.lateralVignetteBase, Style.lateralVignetteAbsolute]->cx} />
        <div className={[Style.gradientBase, Style.gradientAbsolute]->cx} />
      </div>
      <div className={Style.contentGrid}> children </div>
    </section>
  | false =>
    <section className={[Style.container, Style.mobileHero]->cx}>
      {switch renderImage {
      | Some(render) => render(~src, ~alt, ~className=Style.img)
      | None =>
        ReactDOM.createElement(
          "img",
          ~props=Obj.magic({"className": Style.img, "src": src, "srcSet": srcSet, "sizes": sizes, "alt": alt, "fetchPriority": "high"}),
          [],
        )
      }}
      <div className={[Style.lateralVignetteBase, Style.lateralVignetteAbsolute]->cx} />
      <div className={[Style.gradientBase, Style.gradientAbsolute]->cx} />
      <div className={Style.content}> children </div>
    </section>
  }
}
