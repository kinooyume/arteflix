open StorybookMini

let default: meta<InfoModalHero.props> = {
  title: "Molecules/InfoModal/InfoModalHero",
  component: InfoModalHero.make,
}

let imageOnly: storyObj<InfoModalHero.props> = {
  args: {
    imageSrc: "https://api-cdn.arte.tv/img/v2/image/CPSfSGYzXeU98Hv7nPLRXQ/1920x1080",
    imageAlt: "Blood",
    title: "Blood",
    playHref: Some("/fr/videos/RC-028300/blood/"),
  },
}

let withTrailer: storyObj<InfoModalHero.props> = {
  args: {
    imageSrc: "https://api-cdn.arte.tv/img/v2/image/CPSfSGYzXeU98Hv7nPLRXQ/1920x1080",
    imageAlt: "Blood",
    title: "Blood",
    playHref: Some("/fr/videos/RC-028300/blood/"),
    trailer: PlayerTransition.Url("https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8"),
  },
}
