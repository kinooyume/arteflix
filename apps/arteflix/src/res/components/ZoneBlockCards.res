// NOTE: Memoify ?
//
// zone.content.data

let makeCards = (zoneContents: array<ArteZoneContent.t>, ~orientation) =>

  zoneContents->Array.map((content): MovieCard.t => {
    let kindLabel = switch content.kind.label {
    | Some(label) => Some(label)
    | None => None
    }

    let liveLabel = switch content.stickers {
      | Some(stickers) =>
        switch stickers->Array.find(sticker => sticker.code == "LIVE") {
        | Some(liveSticker) => Some(liveSticker.label)
          | None => None
      }
      | None => None
    }

    let imageProps: MovieCardImage.props = {
      id: content.id,
      title: content.title,
      orientation,
      duration: content.duration,
      durationLabel: content.durationLabel,
      srcBase: content.mainImage.url,
      kindLabel,
      alt: content.title,
      href: content.url,
      forceLabel: liveLabel,
    }

    // let url = switch content.trailer {
    //   | Some(trailer) => ToFetch(trailer.id)
    //   | None => NoVideo
    // }
    let previewProps: MoviePreview.props = {
      {
        img: content.mainImage.url,
        href: content.url,
        description: content.teaserText,
        ageRestriction: switch content.ageRating {
        | Some(ageRating) =>
          switch ageRating > 0 {
          | true => Some("-" ++ ageRating->Int.toString)
          | false => None
          }
        | None => None
        },
        audios: switch content.audioVersions {
        | Some(audioVersions) =>
          Some(audioVersions->Array.map(audioVersion => (audioVersion.code :> string)))
        | None => None
        },
      }
    }
    (imageProps, previewProps)
  })

type props_ = {
  zone: ArteZone.t,
  // lang: string,
  key?: string,
  showKind?: bool,
  forceTitle?: bool,
  orientation: MovieCardImage.orientation,
  children: React.component<MovieBlockCards.props>,
}

@react.component(: props_)
let make = (~zone, ~orientation, ~children, ~forceTitle=false,  ~showKind=false) => {
  let cardsCached = React.useCallback(makeCards, (zone, orientation))

  switch zone.authenticatedContent {
  | Some(_) => React.null
  | None => {
      let title = switch forceTitle || zone.displayOptions.showZoneTitle {
      | true => Some(zone.title)
      | false => None
      }

      let showTrailer = showKind || zone.displayTeaserGenre->Option.getOr(false)

      let cards = zone.content.data->cardsCached(~orientation)

      {
        children({
          title,
          key: zone.id ++ "-cards",
          showDuration: zone.displayOptions.showItemTitle,
          cards,
          showTrailer,
        })
      }
    }
  }
}

// let newSize = switch orientation {
// | MovieCardImage.Horizontal => "325x183"
// | MovieCardImage.Vertical => "265x397"
// }
