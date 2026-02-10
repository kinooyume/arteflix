open StorybookMini

let default: meta<PreviewDescriptionDotList.props> = {
  title: "Molecules/Preview/PreviewDescriptionDotList",
  component: PreviewDescriptionDotList.make,
}

let hello: storyObj<PreviewDescriptionDotList.props> = {
  args: {
    children: [
      <p> {"First Line"->React.string} </p>,
      <p> {"Second Line"->React.string} </p>,
      <p> {"Third Line"->React.string} </p>,
    ],
  },
}
