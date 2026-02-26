open Emotion

module Style = {
  let wrapper =
    ReactDOM.Style.make(
      ~display="inline-flex",
      ~flexDirection="column",
      ~padding="20px 0px 88px 0px",
      ~gap=Spacing.md,
      ~width="100%",
      ~boxSizing="border-box",
      ~justifyContent="flex-start",
      ~alignItems="flex-start",
      ~borderRadius="0 0 4px 4px",
      ~backgroundColor=Colors.greyGrey_900,
      (),
    )->css
}

type props_ = {
  key?: string,
  children: React.element,
}

@react.component(: props_)
let make = (~children) => <div className={Style.wrapper}> {children} </div>
