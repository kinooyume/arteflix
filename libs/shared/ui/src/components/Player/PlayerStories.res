open StorybookMini

let default: meta<Player.props> = {
  title: "Molecules/Player/MainPlayer",
  component: Player.make,
}

let live: storyObj<Player.props> = {
  args: {
    // url: "https://artesimulcast.akamaized.net/hls/live/2031003/artelive_fr/index.m3u8",
    url: "https://manifest-arte.akamaized.net/api/manifest/v1/Generate/ddb9adc2-0232-48f5-b466-b9e18796c4e1/fr/XQ+KS/116507-000-A.m3u8",
    options: {
      controls: true,
      autoplay: #play,
      preload: #auto,
      fluid: false,
    },
  },
}

// url: "https://manifest-arte.akamaized.net/api/manifest/v1/Generate/2024092903FFA7B3B1199712B61AD53E1AE55B7798/en/XQ+KS/119382-000-A.m3u8",
