open StorybookMini

let default: meta<HeroTemplate.heroTemplateProps> = {
  component: HeroTemplate.make,
  title: "Organisms/Hero/HeroTemplate",
}

let withCallToAction: storyObj<HeroTemplate.heroTemplateProps> = {
  args: {
    imageSrc: "https://api-cdn.arte.tv/img/v2/image/CPSfSGYzXeU98Hv7nPLRXQ/1920x1080",
    imageAlt: "Documentary scene",
    title: "The Last Mountain",
    subtitle: Some("A journey through the Himalayas"),
    description: Some(
      "An extraordinary documentary following climbers attempting to summit one of the world's most challenging peaks.",
    ),
    url: "/en/videos/123456-000-A/the-last-mountain",
    callToAction: Some("Watch Now"),
  },
}

let minimal: storyObj<HeroTemplate.heroTemplateProps> = {
  args: {
    imageSrc: "https://api-cdn.arte.tv/img/v2/image/CPSfSGYzXeU98Hv7nPLRXQ/1920x1080",
    imageAlt: "Film poster",
    title: "Untitled Film",
    subtitle: None,
    description: None,
    url: "/en/videos/123456-000-A/untitled",
  },
}

let noOverflow: storyObj<HeroTemplate.heroTemplateProps> = {
  args: {
    imageSrc: "https://api-cdn.arte.tv/img/v2/image/CPSfSGYzXeU98Hv7nPLRXQ/1920x1080",
    imageAlt: "Concert performance",
    title: "Live at the Opera",
    subtitle: Some("Berlin Philharmonic"),
    description: Some("A stunning performance captured live at the Berlin State Opera."),
    url: "/en/videos/789012-000-A/live-opera",
    overflow: false,
  },
}
