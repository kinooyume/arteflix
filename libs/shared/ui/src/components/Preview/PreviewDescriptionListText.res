open Emotion

let style = ReactDOM.Style.make(~color={Colors.primaryWhite}, ~margin="0", ())->css

type previewDescriptionListTextProps = {children: string}

@react.component(: previewDescriptionListTextProps)
let make = (~children) => {
  let className = [Typo.Regular.body, style]->cx
  <p className> {children->React.string} </p>
}
