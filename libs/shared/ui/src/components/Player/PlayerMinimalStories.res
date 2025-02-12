open StorybookMini

let default: meta<PlayerMinimal.props> = {
  title: "Molecules/Player/PlayerMinimal",
  component: PlayerMinimal.make,
}

let live: storyObj<PlayerMinimal.props> = {
  args: {
    // url: "https://artesimulcast.akamaized.net/hls/live/2031003/artelive_fr/index.m3u8",
    url: "https://manifest-arte.akamaized.net/api/manifest/v1/Generate/50ed12b3-8812-4f13-b0b0-e98f0b63efd8/de/XQ+KS/PNF1465.m3u8",
    options: {
      autoplay: #play,
      preload: #auto,
      fluid: false,
    },
  },
}

// url: "https://manifest-arte.akamaized.net/api/manifest/v1/Generate/2024092903FFA7B3B1199712B61AD53E1AE55B7798/en/XQ+KS/119382-000-A.m3u8",
