open Emotion

let style =
  ReactDOM.Style.make(
    ~display="inline-flex",
    ~height="16px",
    ~padding="0 6.5px",
    ~justifyContent="center",
    ~alignItems="center",
    ~gap="10px",
    ~borderRadius="4px",
    ~border=`1px solid ${Colors.greyGrey_200}`,
    ~color=Colors.greyGrey_10,
    (),
  )->css

type props_ = {children: string}

@react.component(: props_)
let make = (~children) => {
  <span className={[style, Typo.Regular.caption2]->cx}> {children->React.string} </span>
}
