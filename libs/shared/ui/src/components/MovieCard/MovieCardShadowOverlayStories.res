
open StorybookMini

let default: meta<MovieCardShadowOverlay.props> = {
  title: "Atoms/Card/MovieCardShadowOverlay",
  component: MovieCardShadowOverlay.make,
}

let overlay: storyObj<MovieCardShadowOverlay.props> = {
  args: { children: "2h 42m" },
}
