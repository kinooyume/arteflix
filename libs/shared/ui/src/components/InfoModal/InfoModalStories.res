open StorybookMini

let default: meta<InfoModal.props> = {
  title: "Organisms/InfoModal",
  component: InfoModal.make,
}

let withHero: storyObj<InfoModal.props> = {
  args: {
    label: "Blood",
    onClose: () => (),
    children: <>
      <InfoModalHero
        imageSrc="https://api-cdn.arte.tv/img/v2/image/CPSfSGYzXeU98Hv7nPLRXQ/1920x1080"
        imageAlt="Blood"
        title="Blood"
        playHref=Some("/fr/videos/RC-028300/blood/")
        trailer={PlayerTransition.Url("https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8")}
      />
      <p style={ReactDOM.Style.make(~padding="0 48px 48px", ())}>
        {"À la mort soudaine de sa mère, Cat Hogan retourne en Irlande."->React.string}
      </p>
    </>,
  },
}
