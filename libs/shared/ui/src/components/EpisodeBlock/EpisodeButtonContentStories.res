open StorybookMini

let default: meta<EpisodeButtonContent.props> = {
  title: "Molecules/Episode/EpisodeButtonContent",
  component: EpisodeButtonContent.make,
}

let logo: storyObj<EpisodeButtonContent.props> = {
  args: {
    title: "The Newsreader",
    description: Some( "Melbourne in 1986, a newsreader (Anna Torv) and a young reporter (Sam Reid) team up in the hope of getting ahead in their careers. This Australian series takes us behind the scenes of a TV news programme in a fast-paced drama." ),
    duration: Some("55 min"),
  },
}
