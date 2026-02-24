let heroRenderImage = (~src, ~alt, ~className=?) =>
  <Next.Image src alt ?className width=1920 height=1080 priority=true sizes="100vw" />

let makeHero = (zone: ArteZone.t, ~metadata as _metadata, ~parent as _parent) => {
  switch zone.content.data->Array.get(0) {
  | Some(content) => {
      let imageAlt = switch content.mainImage.caption {
      | Some(caption) => caption
      | None => content.title
      }

      <HeroCollectionTemplate
        imageSrc={ArteImage.resolveUrl(content.mainImage.url, "1920x1080")}
        imageAlt
        title=content.title
        subtitle=content.subtitle
        description=content.shortDescription
        url=content.url
        renderImage=heroRenderImage
      />
    }
  | None => <> </>
  }
}

type props_ = {
  zone: ArteZone.t,
  metadata: option<ArteMetadata.t>,
  parent: option<ArteCollection.parent>,
  id: string,
  lang: string,
  episodes?: array<NetflixMode.episode>,
}

module StreamPlayerMemo = {
let make = React.memo(StreamPlayer.make)
}

@react.component(: props_)
let make = (~id, ~lang, ~zone, ~metadata, ~parent, ~episodes=?) => {
  switch zone.displayOptions.template {
  | #"single-programContent" => <StreamPlayerMemo id lang ?episodes />
  | #"single-collectionContent" => zone->makeHero(~metadata, ~parent)
  | #"tableview-playnext" => <ZoneEpisodeBlock zone id />
  | #"verticalFirstHighlighted-landscape" => <ZoneEpisodeBlock zone id />
  | _ => <Zone zone />
  }
}
