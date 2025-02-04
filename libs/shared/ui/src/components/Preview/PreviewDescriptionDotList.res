let dot =
  <svg width="4" height="4" viewBox="0 0 4 4" fill="none" xmlns="http://www.w3.org/2000/svg">
    <circle cx="2" cy="2" r="2" fill={Colors.greyGrey_200} />
  </svg>

type previewDescriptionListProps = {children: array<React.element>}

@react.component(: previewDescriptionListProps)
let make = (~children) => {
  <PreviewDescriptionList>
    {switch children->Array.length > 1 {
    | true =>
      children
      ->Array.flatMap(child => [child, dot])
      ->Array.slice(~start=0, ~end=-1)
    | false => children
    }->React.array}
  </PreviewDescriptionList>
}
