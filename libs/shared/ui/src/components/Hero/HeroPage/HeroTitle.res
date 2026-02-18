open Emotion
let style = ReactDOM.Style.make(~maxWidth="var(--hero-content-max-width)", ~maxHeight="810px", ~flexShrink="0", ())->css

type heroTitleProps = {
  title: string,
  subtitle: option<string>,
}

@react.component(: heroTitleProps)
let make = (~title, ~subtitle) => {
  <div className={style}>
    <Text.Bold.Title1> {title->React.string} </Text.Bold.Title1>
    {switch subtitle {
    | Some(subtitle) => <Text.Regular.Title1> {subtitle->React.string} </Text.Regular.Title1>
    | None => <> </>
    }}
  </div>
}
