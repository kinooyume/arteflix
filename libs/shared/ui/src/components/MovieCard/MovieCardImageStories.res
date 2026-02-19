open StorybookMini

let default: meta<MovieCardImage.props> = {
  component: MovieCardImage.make,
  title: "Atoms/Cards/MovieCardImage",
}

let horizontal: storyObj<MovieCardImage.props> = {
  args: {
    id: "1",
      kindLabel: None,
      forceLabel: None,
    orientation: MovieCardImage.Horizontal,
      duration: None,
          title: "yo",
      durationLabel: None,
    srcBase: "https://api-cdn.arte.tv/img/v2/image/y4UHNRQxXcYAw5T8aprnDm/336x189?type=TEXT",
    alt: "Movie Poster",
    href: "",
  },
}

// let horizontalWithOverlay: storyObj<MovieCardImage.props> = {
//   args: {
//     id: "1",
//     orientation: MovieCardImage.Horizontal,
//       duration: None,
//       durationLabel: None,
//     srcBase: "https://api-cdn.arte.tv/img/v2/image/y4UHNRQxXcYAw5T8aprnDm/336x189?type=TEXT",
//     alt: "Movie Poster",
//     href: "",
//           title: "yo",
//     children: <MovieCardInnerOverlay text="Recently Added" />,
//   },
// }
//
let vertical: storyObj<MovieCardImage.props> = {
  args: {
    id: "1",
      kindLabel: None,
      forceLabel: None,
    orientation: MovieCardImage.Vertical,
      duration: None,
      durationLabel: None,
    srcBase: "https://api-cdn.arte.tv/img/v2/image/P2nRqjMQfKvVtrfMhgwoE/265x397?type=TEXT",
    alt: "Movie Poster",
    href: "",
          title: "yo",
  },
}

// let verticalWithOverlay: storyObj<MovieCardImage.props> = {
//   args: {
//     id: "1",
//     orientation: MovieCardImage.Vertical,
//       duration: None,
//       durationLabel: None,
//     srcBase: "https://api-cdn.arte.tv/img/v2/image/P2nRqjMQfKvVtrfMhgwoE/265x397?type=TEXT",
//     alt: "Movie Poster",
//     href: "",
//           title: "yo",
//     children: <MovieCardInnerOverlay text="Recently Added" />,
//   },
// }
