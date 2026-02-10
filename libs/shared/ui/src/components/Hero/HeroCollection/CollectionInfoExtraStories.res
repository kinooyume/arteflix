open StorybookMini

let default: meta<CollectionInfo.Extra.props_> = {
  component: CollectionInfo.Extra.make,
  title: "Atoms/Collection/CollectionInfoExtra",
}

let withTags: storyObj<CollectionInfo.Extra.props_> = {
  args: {
    list: ["6 Episodes", "2023", "Crime", "Drama"],
  },
}
