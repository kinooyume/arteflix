let makeHero = (zone: ArteZone.t, ~metadata, ~parent) => {
  switch zone.content.data->Array.get(0) {
  | Some(content) => {
      let imageAlt = switch content.mainImage.caption {
      | Some(caption) => caption
      | None => content.title
      }

      // let extra = []->Array.flat

      <HeroCollectionTemplate
        imageSrc={content.mainImage.url->String.replace("__SIZE__", "1220x686")}
        imageAlt
        title=content.title
        subtitle=content.subtitle
        description=content.shortDescription
        url=content.url
      />
    }
  | None => <> </>
  }
}

let defaultOptions: VideoJs.playerOptions = {
  controls: true,
  preload: #auto,
  fluid: false,
}
let makePlayer = (~playerConfig: ArtePlayerConfig.t) => {
  switch playerConfig.attributes.streams->Array.get(0) {
  | Some(stream) => {
      let options = switch playerConfig.attributes.autoplay {
      | true => {...defaultOptions, autoplay: #any}
      | false => defaultOptions
      }
      <Player url={stream.url} options />
    }
  | None => <p> {"No Stream"->React.string} </p> // TODO: Handler Error no Stream
  }
}

type props_ = {
  zone: ArteZone.t,
  metadata: option<ArteMetadata.t>, // dans la collection uniquement, pour l'instant
  parent: option<ArteCollection.parent>,
  playerConfig: option<ArtePlayerConfig.t>,
  id: string
}
@react.component(: props_)
let make = (~zone, ~playerConfig, ~metadata, ~parent, ~id) => {
  switch zone.displayOptions.template {
  | #"single-programContent" =>
    // Donc ici, c'est les trucs "en plus"
    switch playerConfig {
    | Some(config) => makePlayer(~playerConfig=config)
    | None => <p> {"No playerConfig"->React.string} </p> // TODO: Handler Error no playerConfig
    }
  | #"single-collectionContent" => zone->makeHero(~metadata, ~parent)

  | #"tableview-playnext" => <ZoneEpisodeBlock zone id/>
  | #"verticalFirstHighlighted-landscape" => <ZoneEpisodeBlock zone id/>
  | _ => <Zone zone />
  }
}
