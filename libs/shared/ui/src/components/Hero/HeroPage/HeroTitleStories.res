open StorybookMini


let default: meta<HeroTitle.props> = {

  title: "Atoms/Hero/HeroTitle",
  component: HeroTitle.make,
}

let title: storyObj<HeroTitle.props> = {
  args: {
    title: "The Best Movies",
    subtitle: Some("Watch the best movies in the world"),
  },
}
