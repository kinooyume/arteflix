open StorybookMini

let default: meta<PreviewImage.props> = {
  title: "Atoms/Preview/PreviewImage",
  component: PreviewImage.make,
}

let hello: storyObj<PreviewImage.props> = {
  args: {
    href: "#",
    srcBase: "https://api-cdn.arte.tv/img/v2/image/NL8zV8YeVTdS3ay4ihnf8b/336x189",
  },
}
