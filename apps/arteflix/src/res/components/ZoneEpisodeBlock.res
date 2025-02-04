type props_ = {zone: ArteZone.t, id: string}

let makeEpisode = (content: ArteZoneContent.t, currentId: string) => {
  let description = switch content.fullDescription {
  | Some(description) => Some(description)
  | None =>
    switch content.shortDescription {
    | Some(description) => Some(description)
    | None => None
    }
  }

  let episode: EpisodeButton.t = {
    href: content.url,
    title: content.title,
    id: content.id,
    selected: content.id == currentId,
    imageSrc: content.mainImage.url->String.replace("__SIZE__", "265x149"),
    description,
    duration: content.durationLabel,
    imageAlt: switch content.mainImage.caption {
    | Some(caption) => caption
    | None => content.title
    },
  }
  episode
}

@react.component(: props_)
let make = (~zone, ~id) => {
  let episodes: array<EpisodeButton.t> =
    zone.content.data->Array.map(content => makeEpisode(content, id))
  <EpisodeBlock title=zone.title episodes />
}
