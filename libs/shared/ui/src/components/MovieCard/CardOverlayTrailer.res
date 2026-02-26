open Emotion

module Style = {
  let container =
    ReactDOM.Style.make(
      ~display="flex",
      ~flex="1 0 0",
      ~width="100%",
      ~height="48px",
      ~minHeight="48px",
      ~padding=Spacing.md,
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
