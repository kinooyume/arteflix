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

  let url = content.mainImage.url
  let size = s => url->String.replace("__SIZE__", s)

  let episode: EpisodeButton.t = {
    href: content.url,
    title: content.title,
    id: content.id,
    selected: content.id == currentId,
    imageSrc: size("265x149"),
    imageSrcSet: `${size("210x118")} 210w, ${size("265x149")} 265w`,
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
