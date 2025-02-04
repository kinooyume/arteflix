type props_ = {
  key?: string,
  title: option<string>,
  cards: array<MovieCard.t>,
  linkAlt?: option<LinkAlt.make>,
  sticker?: option<string>,
  showDuration?: bool,
  showTrailer?: bool,
}

// NOTE: on peut meme faire un truc qui prend une option

let durationOverlay = (cardProps: MovieCardImage.props) =>
  switch cardProps.durationLabel {
  | Some(durationLabel) =>
    <MovieCardShadowOverlay key={cardProps.id ++ "-duration-overlay"}>
      {durationLabel}
    </MovieCardShadowOverlay>
  | None => React.null
  }

let labelOverlay = (label: string, id:string) => {
  <MovieCardInnerOverlay key={id ++ "-label-overlay"}>
    <MovieCardSticker key={id ++ "-card-sticker"}>
      {label->React.string}
    </MovieCardSticker>
  </MovieCardInnerOverlay>
}

let kindLabelOverlay = (cardProps: MovieCardImage.props) => {
  switch cardProps.kindLabel {
  | Some(label) => labelOverlay(label, cardProps.id)
  | None => React.null
  }
}

@react.component(: props_)
let make = (~title, ~cards, ~showDuration, ~showTrailer) => {
  let durationCached = React.useCallback(durationOverlay, (cards, showDuration))
  let labelOverlayCached = React.useCallback(kindLabelOverlay, (cards, showTrailer))
  let overlays = []

  // en vrai on peut faire un reduce, avec un tableau de ((bool) => overlay)
  if showDuration {
    overlays->Array.push(durationCached)
  }

  if showTrailer {
    overlays->Array.push(labelOverlayCached)
  }

  <MovieBlock title>
    <MovieCardSlider>
      {cards->Array.map(cardData => {
        // On peut tres bien supprimer le mot props
        let (cardProps, previewProps) = cardData
        <MovieCard key={cardProps.id} cardProps previewProps>
          {overlays->Array.map(overlay => overlay(cardProps))->React.array}
          {switch cardProps.forceLabel {
          | Some(label) => labelOverlay(label, cardProps.id)
          | None => React.null
          }}
        </MovieCard>
      })}
    </MovieCardSlider>
  </MovieBlock>
}
