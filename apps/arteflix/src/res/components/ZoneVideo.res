let makeHeroSrcSet = (url: string) => {
  let size = s => url->String.replace("__SIZE__", s)
  `${size("940x530")} 940w, ${size("1400x787")} 1400w, ${size("1920x1080")} 1920w`
}

let makeHero = (zone: ArteZone.t, ~metadata as _metadata, ~parent as _parent) => {
  switch zone.content.data->Array.get(0) {
  | Some(content) => {
      let imageAlt = switch content.mainImage.caption {
      | Some(caption) => caption
      | None => content.title
      }

      <HeroCollectionTemplate
        imageSrc={content.mainImage.url->String.replace("__SIZE__", "1920x1080")}
        imageSrcSet={makeHeroSrcSet(content.mainImage.url)}
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

type props_ = {
  zone: ArteZone.t,
  metadata: option<ArteMetadata.t>, // dans la collection uniquement, pour l'instant
  parent: option<ArteCollection.parent>,
  id: string,
  lang: string,
}

module StreamPlayerMemo = {
let make = React.memo(StreamPlayer.make)
}

@react.component(: props_)
let make = (~id, ~lang, ~zone, ~metadata, ~parent) => {
  switch zone.displayOptions.template {
  | #"single-programContent" => <StreamPlayerMemo id lang />
  | #"single-collectionContent" => zone->makeHero(~metadata, ~parent)
  | #"tableview-playnext" => <ZoneEpisodeBlock zone id />
  | #"verticalFirstHighlighted-landscape" => <ZoneEpisodeBlock zone id />
  | _ => <Zone zone />
  }
}
