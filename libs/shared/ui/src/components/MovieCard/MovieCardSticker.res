open Emotion

let style =
  [
    Typo.Medium.caption,
    ReactDOM.Style.make(
      ~display="inline-flex",
      ~padding="2px 6px",
      ~justifyContent="center",
      ~alignItems="center",
      ~gap="10px",
      ~borderRadius="2px 2px 0px 0px",
      ~background="#F50723",
      ~color="var(--neutral-white, #FFF)",
      (),
    )->css,
  ]->cx

type props_ = {children: React.element}
@react.component(: props_)
let make = (~children) => {
  <div className={style}> {children} </div>
}
