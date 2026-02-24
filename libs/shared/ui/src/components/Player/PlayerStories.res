open StorybookMini

let default: meta<Player.props> = {
  title: "Molecules/Player/MainPlayer",
  component: Player.make,
}

let live: storyObj<Player.props> = {
  args: {
    url: "https://manifest-arte.akamaized.net/api/manifest/v1/Generate/ddb9adc2-0232-48f5-b466-b9e18796c4e1/fr/XQ+KS/116507-000-A.m3u8",
    options: {
      controls: true,
      autoplay: #play,
      preload: #auto,
      fluid: false,
    },
    title: "Kaizen",
    episodes: [
      {title: "Le Chemin", subtitle: Some("S1 E1"), href: "#ep1", selected: true},
      {title: "La Montagne", subtitle: Some("S1 E2"), href: "#ep2", selected: false},
      {title: "Le Sommet", subtitle: Some("S1 E3"), href: "#ep3", selected: false},
    ],
  },
}
