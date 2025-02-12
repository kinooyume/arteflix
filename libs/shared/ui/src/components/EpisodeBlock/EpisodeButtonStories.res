open StorybookMini

let default: meta<EpisodeButton.props> = {
  title: "Molecules/Episode/EpisodeButton",
  component: EpisodeButton.make,
}

let logo: storyObj<EpisodeButton.props> = {
  args: {
    index: 1,
    id: "super-video",
      selected: false,
    href: "#",
    title: "The Newsreader",
    description: Some( "Melbourne in 1986, a newsreader (Anna Torv) and a young reporter (Sam Reid) team up in the hope of getting ahead in their careers. This Australian series takes us behind the scenes of a TV news programme in a fast-paced drama." ),
    duration: Some("55 min"),
      imageAlt: "Arteflix Logo",
      imageSrc: "https://api-cdn.arte.tv/img/v2/image/AdNaCeYv8wePtPa2nfyvdW/265x149",
  },
}
