open Emotion

module Styles = {
  let container =
    ReactDOM.Style.make(
      ~display="flex",
      ~justifyContent="flex-end",
      ~alignItems="flex-start",
      ~position="absolute",
      ~top="0",
      ~bottom="0",
      ~left="0",
      ~right="0",
      ~width="100%",
      ~height="100%",
      ~flexShrink="0",
      ~background="linear-gradient(207deg, rgba(23, 23, 23, 0.70) 5.75%, rgba(23, 23, 23, 0.50) 16.37%, rgba(23, 23, 23, 0.00) 32.31%)",
      (),
    )->css

  let text = ReactDOM.Style.make(~textAlign="right", 
    ~margin="0",
    ~padding="7px 12px 0 0",
    ~color=Colors.primaryWhite, ())->css
}

// 7 / 12

type props_ = {children: string}

@react.component(: props_)
let make = (~children) => {
  <div className=Styles.container>
    <p className={[Typo.Regular.body, Styles.text]->cx}> {children->React.string} </p>
  </div>
}
