open StorybookMini

let default: meta<HeroTemplate.props> = {
  title: "Design System/Organisms/Hero (slider-square)",
  component: HeroTemplate.make,
}

let hello: storyObj<HeroTemplate.props> = {
  args: {
    imageSrc: "https://api-cdn.arte.tv/img/v2/image/YNkVmsnAtwN3Tom7rTTFBE/1121x632",
    imageAlt: "Hello",
    title: "Hong Kong: As Democracy Dies",
    subtitle: Some("ARTE Reportage"),
    description: Some(
      "The recent national security law continues to brutally restrict freedoms as China tightens its grip on the territory.",
    ),
    url: "Hello",
  },
}
