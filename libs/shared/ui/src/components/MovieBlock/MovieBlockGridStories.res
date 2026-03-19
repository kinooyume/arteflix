open StorybookMini

let default: meta<MovieBlockGrid.props> = {
  title: "Organisms/MovieBlock/MovieBlockGrid",
  component: MovieBlockGrid.make,
}

let sampleCard: MovieCard.t = (
  {
    id: "1",
    srcBase: "https://api-cdn.arte.tv/img/v2/image/P2nRqjMQfKvVtrfMhgwoE/__SIZE__?type=TEXT",
    kindLabel: None,
    forceLabel: None,
    alt: "Movie Poster",
    href: "",
    title: "Sample Movie",
    duration: Some(5400),
    durationLabel: Some("90 min"),
    orientation: Horizontal,
  },
  {
    img: "https://api-cdn.arte.tv/img/v2/image/NL8zV8YeVTdS3ay4ihnf8b/336x189?type=TEXT",
    href: "https://kinoo.dev",
    description: Some("A compelling documentary about modern society."),
    ageRestriction: Some("+16"),
    audios: Some(["VF", "VO"]),
  },
)

let cards = Array.make(~length=12, sampleCard)

let withTitle: storyObj<MovieBlockGrid.props> = {
  args: {
    title: Some("Les plus récents"),
    link: Some("/fr/videos/RC-024031/les-plus-recents"),
    cards,
  },
}

let withoutTitle: storyObj<MovieBlockGrid.props> = {
  args: {
    title: None,
    cards,
  },
}
