open Emotion
open ReactAria

let style = ReactDOM.Style.make(~height="28px", ~outline="none !important", ())->css

type logoProps = {
  src: string,
  homeHref: string,
  alt: string
}

@react.component(: logoProps)
let make = (~homeHref, ~alt, ~src) => <Link className={String(style)} href={homeHref}>
  <img style={{height: "28px"}} className={style} src alt/>
</Link>
