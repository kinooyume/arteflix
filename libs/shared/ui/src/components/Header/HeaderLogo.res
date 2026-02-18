open Emotion
open ReactAria

let style = ReactDOM.Style.make(~height="clamp(22px, 1.2rem + 0.5vw, 28px)", ~outline="none !important", ())->css

type logoProps = {
  src: string,
  homeHref: string,
  alt: string
}

@react.component(: logoProps)
let make = (~homeHref, ~alt, ~src) => <Link className={String(style)} href={homeHref}>
  <img className={style} src alt/>
</Link>
