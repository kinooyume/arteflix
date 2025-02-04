open Emotion

module Style = {
  let container =
    ReactDOM.Style.make(
      ~display="flex",
      ~flexDirection="column",
      ~padding="20px 0px 46px 58px",
      ~alignItems="flex-start",
      ~gap="15px",
      ~zIndex="2",
      ~background="linear-gradient(180deg, rgba(20, 20, 20, 0.00) 0%, rgba(20, 20, 20, 0.15) 11.03%, rgba(20, 20, 20, 0.35) 23.77%, rgba(20, 20, 20, 0.58) 47.76%, #141414 91.44%)",
      (),
    )->css
}

type movieHomeBlockProps = {
  title: option<string>,
  children: React.element,
}

open Text

@react.component(: movieHomeBlockProps)
let make = (~title, ~children) => {
  <div className={Style.container}>
    {switch title {
    | Some(title) => <Medium.Headline2> {title->React.string} </Medium.Headline2>
    | None => <> </>
    }}
    children
  </div>
}
