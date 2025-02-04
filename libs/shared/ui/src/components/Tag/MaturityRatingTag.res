open Emotion

let style =
  ReactDOM.Style.make(
    ~display="inline-flex",
    ~height="22px",
    ~padding="0px 6.5px",
    ~justifyContent="center",
    ~alignItems="center",
    ~gap="10px",
    ~flexShrink="0",
    ~border=`1px solid ${Colors.greyGrey_50}`,
    ~color=Colors.greyGrey_50,
    (),
  )->css

type props_ = {children: string}

@react.component(: props_)
let make = (~children) => {
  <span className={[style, Typo.Regular.body]->cx}> {children->React.string} </span>
}
