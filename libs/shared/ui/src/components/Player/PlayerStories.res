open StorybookMini

let default: meta<Player.props> = {
  title: "Molecules/Player/MainPlayer",
  component: Player.make,
}

let live: storyObj<Player.props> = {
  args: {
    url: "https://manifest-arte.akamaized.net/api/manifest/v1/Generate/ddb9adc2-0232-48f5-b466-b9e18796c4e1/fr/XQ+KS/116507-000-A.m3u8",
    options: {
      controls: true,
      autoplay: #play,
      preload: #auto,
      fluid: false,
    },
    title: "Kaizen",
  },
}
