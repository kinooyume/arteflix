open StorybookMini

let default: meta<PreviewDescriptionList.props> = {
  title: "Molecules/Preview/PreviewDescriptionList",
  component: PreviewDescriptionList.make,
}

let hello: storyObj<PreviewDescriptionList.props> = {
  args: {
    children: <>
      <p> {"First Line"->React.string} </p>
      <p> {"Second Line"->React.string} </p>
      <p> {"Third Line"->React.string} </p>
    </>,
  },
}
