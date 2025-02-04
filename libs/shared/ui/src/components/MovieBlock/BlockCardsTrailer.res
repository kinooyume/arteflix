let durationOverlay = (cardProps: MovieCardImage.props) =>
  switch cardProps.durationLabel {
  | Some(durationLabel) => <MovieCardShadowOverlay> {durationLabel} </MovieCardShadowOverlay>
  | None => React.null
  }

let trailerOverlay = (cardProps: MovieCardImage.props) =>
  <MovieCardInnerOverlay>
    <CardOverlayTrailer> {cardProps.title->React.string} </CardOverlayTrailer>
  </MovieCardInnerOverlay>

@react.component(: MovieBlockCards.props)
let make = (~title, ~cards, ~showDuration) => {
  let durationCached = React.useCallback(durationOverlay, (cards, showDuration))
  let trailerTitleCached = React.useCallback(trailerOverlay, cards)

  // NOTE: memoization ici
  let overlays = []
  overlays->Array.push(trailerTitleCached)

  if showDuration {
    overlays->Array.push(durationCached)
  }

  // TODO: check if title/id are really optional
  let key = `${switch title {
    | Some(t) => t
    | None => ""
    }}`

  <MovieBlock title key={key}>
    <MovieCardSlider>
      {cards->Array.map(cardData => {
        // On peut tres bien supprimer le mot props
        let (cardProps, previewProps) = cardData
        <MovieCardImage {...cardProps} key={`${key}-${cardProps.id}-image`} ensureText=false>
          {overlays
          ->Array.mapWithIndex((overlay, index) =>
            <React.Fragment key={`${key}-${cardProps.id}-${index->Int.toString}-overlay`}>
              {overlay(cardProps)}
            </React.Fragment>
          )
          ->React.array}
        </MovieCardImage>
      })}
    </MovieCardSlider>
  </MovieBlock>
}
