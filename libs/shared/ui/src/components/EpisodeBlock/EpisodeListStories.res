open StorybookMini

let default: meta<EpisodeList.props> = {
  title: "Molecules/Episode/EpisodeList",
  component: EpisodeList.make,
}

let logo: storyObj<EpisodeList.props> = {
  args: {
    episodes: [
      {
        href: "#",
      id: "title",
      selected: false,
        title: "The Newsreader",
        description: Some(
          "Melbourne in 1986, a newsreader (Anna Torv) and a young reporter (Sam Reid) team up in the hope of getting ahead in their careers. This Australian series takes us behind the scenes of a TV news programme in a fast-paced drama.",
        ),
        duration: Some("55 min"),
        imageAlt: "Arteflix Logo",
        imageSrc: "https://api-cdn.arte.tv/img/v2/image/AdNaCeYv8wePtPa2nfyvdW/265x149",
      },
      {
        href: "#",
      id: "title",
      selected: false,
        title: "The Newsreader",
        description: Some(
          "Melbourne in 1986, a newsreader (Anna Torv) and a young reporter (Sam Reid) team up in the hope of getting ahead in their careers. This Australian series takes us behind the scenes of a TV news programme in a fast-paced drama.",
        ),
        duration: Some("55 min"),
        imageAlt: "Arteflix Logo",
        imageSrc: "https://api-cdn.arte.tv/img/v2/image/AdNaCeYv8wePtPa2nfyvdW/265x149",
      },
      {
        href: "#",
      id: "title",
      selected: false,
        title: "The Newsreader",
        description: Some(
          "Melbourne in 1986, a newsreader (Anna Torv) and a young reporter (Sam Reid) team up in the hope of getting ahead in their careers. This Australian series takes us behind the scenes of a TV news programme in a fast-paced drama.",
        ),
        duration: Some("55 min"),
        imageAlt: "Arteflix Logo",
        imageSrc: "https://api-cdn.arte.tv/img/v2/image/AdNaCeYv8wePtPa2nfyvdW/265x149",
      },
    ],
  },
}
