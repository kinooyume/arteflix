open Emotion

module Style = {
  let wrapper =
    ReactDOM.Style.make(
      ~backgroundColor=Colors.greyGrey_900,
      ~display="flex-inline",
      ~flexDirection="column",
      ~padding="20px 0px 88px 0px",
      ~gap="16px",
      ~width="100%",
      ~justifyContent="flex-start",
      ~alignItems="flex-start",
      ~borderRadius="0 0 4px 4px",
      (),
    )->css
}

type props_ = {
  key?: string,
  children: React.element,
}

@react.component(: props_)
let make = (~children) => <div className={Style.wrapper}> {children} </div>
