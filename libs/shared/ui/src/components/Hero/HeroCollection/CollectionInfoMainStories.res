open StorybookMini

let default: meta<CollectionInfo.Main.props_> = {
  component: CollectionInfo.Main.make,
  title: "Molecules/Collection/CollectionInfoMain",
}

let withAll: storyObj<CollectionInfo.Main.props_> = {
  args: {
    subtitle: Some("Nordic Noir Drama"),
    description: Some(
      "A gripping six-part series exploring the darker side of Scandinavian society through interconnected stories.",
    ),
  },
}

let subtitleOnly: storyObj<CollectionInfo.Main.props_> = {
  args: {
    subtitle: Some("Documentary Series"),
    description: None,
  },
}
