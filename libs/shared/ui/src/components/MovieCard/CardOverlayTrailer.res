open Emotion

module Style = {
  let container =
    ReactDOM.Style.make(
      ~display="flex",
      ~flex="1 0 0",
      ~width="218px",
      ~height="68px",
      ~minHeight="68px",
      ~padding="16px",
      ~justifyContent="center",
      ~alignItems="center",
      ~gap="10px",
      ~color=Colors.primaryWhite,
      ~backgroundColor=Colors.greyGrey_500,
      (),
    )->css
}

type props_ = {children: React.element}

@react.component(: props_)
let make = (~children) => {
  <div className={[Style.container, Typo.Medium.trailer]->cx}> children </div>
}
