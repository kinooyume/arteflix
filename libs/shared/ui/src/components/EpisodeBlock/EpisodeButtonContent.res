open Emotion

module Style = {
  let container =
    ReactDOM.Style.make(
      ~display="flex",
      ~flexDirection="column",
      ~gap="8px",
      ~width="100%",
      ~padding="16px 14px",
      (),
    )->css

  let title =
    ReactDOM.Style.make(
      ~display="flex",
      ~justifyContent="space-between",
      ~paddingLeft="2px",
      (),
    )->css
}

type props_ = {
  title: string,
  description?: option<string>,
  duration: option<string>,
}

open Text
@react.component(: props_)
let make = (~title, ~description=None, ~duration) => {
  <div className={Style.container}>
    <div className={Style.container}>
      <div className={Style.title}>
        <Regular.Body> {title->React.string} </Regular.Body>
        {switch duration {
        | Some(label) => <Regular.Body> {label->React.string} </Regular.Body>
        | None => React.null
        }}
      </div>
      {switch description {
      | Some(desc) => <Regular.SmallBody> {desc->React.string} </Regular.SmallBody>
      | None => React.null
      }}
    </div>
  </div>
}
