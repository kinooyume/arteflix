open StorybookMini

let default: meta<HeroCollectionTemplate.heroTemplateProps> = {
  component: HeroCollectionTemplate.make,
  title: "Organisms/Hero/HeroCollectionTemplate",
}

let withExtra: storyObj<HeroCollectionTemplate.heroTemplateProps> = {
  args: {
    imageSrc: "https://api-cdn.arte.tv/img/v2/image/CPSfSGYzXeU98Hv7nPLRXQ/1920x1080",
    imageAlt: "Series poster",
    title: "The Investigation",
    subtitle: Some("Nordic Noir Series"),
    description: Some(
      "A gripping true-crime drama based on the investigation of a journalist's disappearance.",
    ),
    url: "/en/videos/RC-024512/the-investigation",
    extra: ["6 Episodes", "2023", "Crime"],
  },
}

let minimal: storyObj<HeroCollectionTemplate.heroTemplateProps> = {
  args: {
    imageSrc: "https://api-cdn.arte.tv/img/v2/image/CPSfSGYzXeU98Hv7nPLRXQ/1920x1080",
    imageAlt: "Collection poster",
    title: "Documentary Collection",
    subtitle: None,
    description: None,
    url: "/en/videos/RC-024513/docs",
  },
}
