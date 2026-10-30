open StorybookMini

let default: meta<MoviePreview.props> = {
  title: "Organisms/Preview/MoviePreview",
  component: MoviePreview.make,
}

let live: storyObj<MoviePreview.props> = {
  args: {
    img: "https://api-cdn.arte.tv/img/v2/image/QN26R4nPzmumvCfKFcQJNc/336x189?type=TEXT",
    href: "https://kinoo.dev",
    description: Some(
      "The recent national security law continues to brutally restrict freedoms as China tightens its grip on the territory.",
    ),
    ageRestriction: Some("+16"),
    audios: Some(["VF", "VO"]),
  },
}

let withTrailer: storyObj<MoviePreview.props> = {
  args: {
    img: "https://api-cdn.arte.tv/img/v2/image/QN26R4nPzmumvCfKFcQJNc/620x350?type=TEXT",
    href: "https://kinoo.dev",
    description: Some("The trailer fades in over the image once it can play."),
    ageRestriction: Some("+16"),
    audios: Some(["VF", "VO"]),
    isVisible: true,
    url: PlayerTransition.Url("https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8"),
  },
}

// url: "https://manifest-arte.akamaized.net/api/manifest/v1/Generate/2024092903FFA7B3B1199712B61AD53E1AE55B7798/en/XQ+KS/119382-000-A.m3u8",
