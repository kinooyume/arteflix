open Emotion

let style =
  ReactDOM.Style.make(
    ~display="flex",
    ~padding="0px 20px",
    ~justifyContent="space-between",
    ~alignItems="center",
    (),
  )->css

type props_ = {
  key?: string,
  children: React.element,
}

@react.component(: props_)
let make = (~children) => <div className={style}> children </div>
