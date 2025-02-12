open StorybookMini

let default: meta<MoviePreview.props> = {

  title: "Organisms/Preview/MoviePreview",
  component: MoviePreview.make,
}

let live: storyObj<MoviePreview.props> = {
  args: {
    img:  "https://api-cdn.arte.tv/img/v2/image/NL8zV8YeVTdS3ay4ihnf8b/325x183?type=TEXT",
    href: "https://kinoo.dev",
    description: Some("The recent national security law continues to brutally restrict freedoms as China tightens its grip on the territory."),
    ageRestriction: Some("+16"),
    audios: Some(["VF", "VO"]),
  },
}

// url: "https://manifest-arte.akamaized.net/api/manifest/v1/Generate/2024092903FFA7B3B1199712B61AD53E1AE55B7798/en/XQ+KS/119382-000-A.m3u8",
