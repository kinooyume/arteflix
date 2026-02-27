open Emotion

module PlayerWithOverlay = {
  type storyProps = {url: string, title: string, subtitle?: string}

  @react.component(: storyProps)
  let make = (~url, ~title, ~subtitle=?) => {
    let (player, setPlayer) = React.useState(() => Js.Nullable.null)

    let containerStyle =
      `
      position: relative;
      width: 100%;
      height: 100dvh;
    `->rawCss

    <div className={containerStyle}>
      <Player
        url
        options={{controls: true, autoplay: #play, preload: #auto, fluid: false}}
        onPlayer={p => setPlayer(_ => Js.Nullable.Value(p))}
      />
      <PlayerOverlay player title ?subtitle />
    </div>
  }
}

open StorybookMini

let default: meta<PlayerWithOverlay.props> = {
  title: "Molecules/Player/PlayerOverlay",
  component: PlayerWithOverlay.make,
}

let withSubtitle: storyObj<PlayerWithOverlay.props> = {
  args: {
    url: "https://manifest-arte.akamaized.net/api/manifest/v1/Generate/ddb9adc2-0232-48f5-b466-b9e18796c4e1/fr/XQ+KS/116507-000-A.m3u8",
    title: "Kaizen",
    subtitle: "Au coeur de Tokyo, un jeune livreur de sushis se retrouve embarqu\u00E9 dans un engrenage yakuza.",
  },
}

let titleOnly: storyObj<PlayerWithOverlay.props> = {
  args: {
    url: "https://manifest-arte.akamaized.net/api/manifest/v1/Generate/ddb9adc2-0232-48f5-b466-b9e18796c4e1/fr/XQ+KS/116507-000-A.m3u8",
    title: "Kaizen",
  },
}
