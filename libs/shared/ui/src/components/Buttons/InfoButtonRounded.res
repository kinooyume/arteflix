open Emotion

module Style = {
  let chevron = `
    display: flex;
    transform: rotate(90deg);
  `->rawCss
}

type infoButtonRoundedProps = {href: string}

@react.component(: infoButtonRoundedProps)
let make = (~href) =>
  <Button href size=Rounded variant=Tertiary>
    <span className={Style.chevron}>
      <Svg.Chevron color={Colors.primaryWhite} size="28" />
    </span>
  </Button>
