open StorybookMini

let default: meta<HeroImage.props_> = {
  component: HeroImage.make,
  title: "Molecules/Hero/HeroImage",
}

let withContent: storyObj<HeroImage.props_> = {
  args: {
    src: "https://api-cdn.arte.tv/img/v2/image/CPSfSGYzXeU98Hv7nPLRXQ/1920x1080",
    alt: "Hero background image",
    children: <div style={ReactDOM.Style.make(~color="white", ~fontSize="2rem", ())}>
      {"Hero Content Goes Here"->React.string}
    </div>,
  },
}

let withOverflow: storyObj<HeroImage.props_> = {
  args: {
    src: "https://api-cdn.arte.tv/img/v2/image/CPSfSGYzXeU98Hv7nPLRXQ/1920x1080",
    alt: "Hero background with overflow",
    overflow: true,
    children: <div style={ReactDOM.Style.make(~color="white", ~fontSize="2rem", ())}>
      {"Full Height Hero"->React.string}
    </div>,
  },
}
