open Emotion
open ReactAria

// https://uiverse.io/JaydipPrajapati1910/green-catfish-37
module Style = {
  let container =
    ReactDOM.Style.make(
      ~display="flex",
      ~alignItems="center",
      ~textDecoration="none",
      ~outline="none",
      (),
    )->css

  let link =
    ReactDOM.Style.make(
      ~display="flex",
      ~alignItems="center",
      ~textDecoration="none",
      ~outline="none",
      (),
    )->css

    let linkHover = [link, ReactDOM.Style.make(


  )->css]->cx
  let chevronWrapper = ReactDOM.Style.make(~position="absolute", ~left="0", ())->css
}

open Svg
type props_ = {text: string, href: string}
@react.component(: props_)
let make = (~text, ~href) => {
  let className: Link.classNameFn = ({isHovered}) => isHovered ? Style.linkHover : Style.link
  <div className={Style.container}>
    <Link href className={Fn(className)}>
      <Text.Medium.SmallBodyGreen> {text->React.string} </Text.Medium.SmallBodyGreen>
      <Chevron size="28px" color={Colors.secondaryGreen} />
    </Link>
  </div>
}
