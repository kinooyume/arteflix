open Emotion

module Main = {
  module Style = {
    let container =
      ReactDOM.Style.make(
        ~display="inline-flex",
        ~flexDirection="column",
        ~position="relative",
        ~maxWidth="881px",
        ~alignItems="flex-start",
        ~gap="16px",
        ~color=Colors.primaryWhite,
        (),
      )->css
  }

  type props_ = {
    subtitle: option<string>,
    description: option<string>,
  }

  @react.component(: props_)
  let make = (~subtitle, ~description) =>
    <div className={Style.container}>
      {switch subtitle {
      | Some(content) => <h2 className={Typo.Regular.subtitle}> {content->React.string} </h2>
      | None => React.null
      }}
      {switch description {
      | Some(content) => <p className={Typo.Medium.description}> {content->React.string} </p>
      | None => React.null
      }}
    </div>
}

module Extra = {
  module Style = {
    let container =
      ReactDOM.Style.make(
        ~display="flex",
        ~width="240px",
        ~flexDirection="column",
        ~alignItems="flex-start",
        ~gap="14px",
        ~flexShrink="0",
        ~color=Colors.primaryWhite,
        (),
      )->css
  }

  type props_ = {list: array<string>}

  @react.component(: props_)
  let make = (~list) =>
    <div className={[Style.container, Typo.Regular.smallBody]->cx}>
      {list->Array.map(line => <p> {line->React.string} </p>)->React.array}
    </div>
}

module Container = {
  module Style = {
    let container =
      ReactDOM.Style.make(
        ~display="inline-flex",
        ~flexDirection="row",
        ~width="100%",
        ~alignItems="space-between",
        ~gap="32px",
        ~padding="20px 58px 46px 58px",
        (),
      )->css
  }

  type props_ = {
    extra: React.element,
    children: React.element,
  }

  @react.component(: props_)
  let make = (~children, ~extra) =>
    <div className={Style.container}>
      {<>
        {children}
        {extra}
      </>}
    </div>
}
