open Emotion

module Style = {
  let container =
    ReactDOM.Style.make(
      ~display="flex",
      ~flexDirection="column",
      ~gap="clamp(12px, 0.5rem + 0.8vw, 22px)",
      ~maxWidth="var(--hero-content-max-width)",
      ~flexShrink="0",
      (),
    )->css
  let small = ReactDOM.Style.make(~gap="36px", ())->css
  let buttonWrapper = ReactDOM.Style.make(~display="flex", ())->css
}
type props_ = {
  title: string,
  subtitle: option<string>,
  description: option<string>,
  small?: bool,
  href: string,
  callToAction?: option<string>,
}

@react.component(: props_)
let make = (~title, ~subtitle, ~description, ~small=false, ~href, ~callToAction=None) => {
  let className = switch small {
  | true => [Style.container, Style.small]->cx
  | false => Style.container
  }
  <div className>
    <HeroTitle title={title} subtitle={subtitle} />
    {switch description {
    | Some(description) => <Text.Regular.Headline2> {description->React.string} </Text.Regular.Headline2>
    | None => <> </>
    }}
    {switch callToAction {
    | Some(text) =>
      <div className={Style.buttonWrapper}>
        <ButtonPlay href text />
      </div>
    | None => React.null
    }}
  </div>
}
