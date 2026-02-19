let heroRenderImage = (~src, ~alt, ~className=?) =>
  <Next.Image src alt ?className width=1920 height=1080 priority=true sizes="100vw" />

let makeHero = (zone: ArteZone.t) => {
  switch zone.content.data->Array.get(0) {
  | Some(content) => {
      let imageAlt = switch content.mainImage.caption {
      | Some(caption) => caption
      | None => content.title
      }
      <HeroTemplate
        imageSrc={ArteImage.resolveUrl(content.mainImage.url, "1920x1080")}
        imageAlt
        title=content.title
        subtitle=content.subtitle
        description=content.teaserText
        callToAction=content.callToAction
        url=content.url
        renderImage=heroRenderImage
      />
    }
  | None => <> </>
  }
}

@react.component
let make = (~zone: ArteZone.t) => {
  switch zone.content.data->Array.length == 0 {
  | true => React.null
  | false =>
    switch zone.displayOptions.template {
    | #"slider-square" => zone->makeHero
    | #"horizontal-landscapeBig" =>
      <ZoneBlockCards key=`zone-${zone.id}` zone orientation=MovieCardImage.Horizontal>
        MovieBlockCards.make
      </ZoneBlockCards>
    | #"horizontal-landscapeBigWithSubtitle" =>
      <ZoneBlockCards key=zone.id zone orientation=MovieCardImage.Horizontal>
        MovieBlockCards.make
      </ZoneBlockCards>
    | #"horizontal-portrait" =>
      <ZoneBlockCards key=zone.id zone orientation=MovieCardImage.Horizontal>
        MovieBlockCards.make
      </ZoneBlockCards>
    | #"horizontal-landscape" =>
      <ZoneBlockCards key=zone.id zone orientation=MovieCardImage.Horizontal>
        MovieBlockCards.make
      </ZoneBlockCards>
    | #"horizontal-landscape-genre" =>
      <ZoneBlockCards key=zone.id zone orientation=MovieCardImage.Horizontal forceTitle=true>
        BlockCardsTrailer.make
      </ZoneBlockCards>
    | #"single-newsletter" => React.null
    | #"event-textOnLeftSide" => React.null
    | #"event-textOnRightSide" => React.null
    | _ => React.null
    // | _ =>
    //   <div>
    //     <p> {(zone.displayOptions.template :> string)->React.string} </p>
    //     <ul className="content">
    //       {zone.content.data
    //       ->Array.map(content => <ZoneContentInfo content />)
    //       ->React.array}
    //     </ul>
    //   </div>
    }
  }
}

// @react.component
// let make = (~zone: ArteZone.t) =>
//   switch zone.displayOptions.template {
//   | #"slider-square" => <HorizontalPortrait zone />
//   | #"horizontal-landscapeBigWithSubtitle" => <HorizontalPortrait zone />
//   | #"horizontal-portrait" => <HorizontalPortrait zone />
//   | #"horizontal-landscape" => <HorizontalPortrait zone />
//   | #"horizontal-landscape-genre" => <HorizontalPortrait zone />
//   | #"event-textOnRightSide" => <HorizontalPortrait zone />
//   | #"single-newsletter" => <HorizontalPortrait zone />
//   }
//

// let makeMovieGenres = (content: ArteZoneContent.t) => {
//   let a = content.stickers->Array.map(sticker => {
//     (sticker.code :> string)
//   })
//   switch content.childrenCount {
//   | Some(childrenCount) => a->Array.push(`${childrenCount->Int.toString} Episodes`)
//   | None => ()
//   }
//   a
//   //
//   // switch content.genre {
//   // | Some(genre) =>
//   //   switch genre.label {
//   //   | Some(label) => [label] // + url
//   //   | None => []
//   //   }
//   // | None => []
//   // }
// }

// Tant pis
// module Link = {
//   @react.component(: LinkAlt.props_)
//   let make = (~href: string, ~children: React.element) => <Next.Link href> {children} </Next.Link>
// }

// let makeMovieMeta = (content: ArteZoneContent.t) => {
//   let meta = []
//   switch content.ageRating {
//   | Some(ageRating) => meta->Array.push(ageRating->Int.toString) // > 0
//   | None => ()
//   }
//
//   switch content.audioVersions {
//   | Some(audioVersions) => {
//       audioVersions->Array.forEach(audioVersion => {
//         meta->Array.push((audioVersion.code :> string))
//       })
//       ()
//     }
//   | None => ()
//   }

// switch content.duration {
// | Some(duration) => meta->Array.push(duration->Int.toString)
// | None => ()
// }
//   meta
// }
