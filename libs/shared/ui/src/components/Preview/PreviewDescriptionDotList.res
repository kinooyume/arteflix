type previewDescriptionListProps = {children: array<React.element>}

@react.component(: previewDescriptionListProps)
let make = (~children) => {
  <PreviewDescriptionList>
    {switch children->Array.length > 1 {
    | true =>
      children
      ->Array.flatMapWithIndex((child, index) => [
        child,
        <Svg.Dot key={`${index->Int.toString}-dot`} color={Colors.greyGrey_200} />,
      ])
      ->Array.slice(~start=0, ~end=-1)
    | false => children
    }->React.array}
  </PreviewDescriptionList>
}
