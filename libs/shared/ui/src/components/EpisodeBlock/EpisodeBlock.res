open Emotion

// TODO: only one block component
module Style = {
  let container =
    ReactDOM.Style.make(
      ~display="flex",
      ~flexDirection="column",
      ~padding="20px var(--side-padding) var(--section-gap) var(--side-padding)",
      ~alignItems="flex-start",
      ~gap="15px",
      ~background="linear-gradient(180deg, rgba(20, 20, 20, 0.00) 0%, rgba(20, 20, 20, 0.15) 11.03%, rgba(20, 20, 20, 0.35) 23.77%, rgba(20, 20, 20, 0.58) 47.76%, #141414 91.44%)",
      ())->css
  let title =
    ReactDOM.Style.make(
      ~display="flex",
      ~width="100%",
      ~boxSizing="border-box",
      ~flexDirection="row",
      ~justifyContent="space-between",
      ~alignItems="center",
      (),
    )->css
}

type props_ = {
  title: string,
  episodes: array<EpisodeButton.t>,
}

open Text
@react.component(: props_)
let make = (~episodes, ~title) => {
  <div className=Style.container>
    <div className=Style.title>
      <Medium.Title3> {"Episodes"->React.string} </Medium.Title3>
      <Regular.Headline1> {title->React.string} </Regular.Headline1>
    </div>
    <EpisodeList episodes />
  </div>
}
