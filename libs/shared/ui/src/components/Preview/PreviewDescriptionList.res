open Emotion

let style = ReactDOM.Style.make(~display="flex", ~alignItems="center", ~gap=Spacing.sm, ())->css

type previewDescriptionListProps = {children: React.element}

@react.component(: previewDescriptionListProps)
let make = (~children) => {
  <div className=style> children </div>
}
