open StorybookMini

let placeholder =
  <div
    style={ReactDOM.Style.make(~height="100px", ~background="#333", ~borderRadius="4px", ~width="100%", ())}
  />

let default: meta<MovieBlock.movieHomeBlockProps> = {
  title: "Organisms/MovieBlock/MovieBlock",
  component: MovieBlock.make,
}

let withTitle: storyObj<MovieBlock.movieHomeBlockProps> = {
  args: {
    title: Some("Tendances du moment"),
    children: placeholder,
  },
}

let withLink: storyObj<MovieBlock.movieHomeBlockProps> = {
  args: {
    title: Some("Tendances du moment"),
    link: Some("/fr/videos/RC-024031/tendances"),
    children: placeholder,
  },
}

let noTitle: storyObj<MovieBlock.movieHomeBlockProps> = {
  args: {
    title: None,
    children: placeholder,
  },
}
