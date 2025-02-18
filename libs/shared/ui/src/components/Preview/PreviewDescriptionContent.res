open Emotion

let style =
  ReactDOM.Style.make(
    ~display="flex",
    ~padding="0 12px",
    ~height="300px",
    ~width="299px",
    ~flexDirection="column",
    ~alignItems="flex-start",
    ~gap="14px",
    ~color=Colors.greyGrey_25,
    (),
  )->css

type contentProps = {children: React.element}

@react.component(: contentProps)
let make = (~children) => {
  <div className={[style, Typo.Regular.smallBody]->cx}> children </div>
}
