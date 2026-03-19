open Emotion

module Style = {
  let grid = `
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 8px;
    width: 100%;

    @media (min-width: 600px) {
      grid-template-columns: repeat(3, 1fr);
    }
    @media (min-width: 900px) {
      grid-template-columns: repeat(4, 1fr);
    }
    @media (min-width: 1400px) {
      grid-template-columns: repeat(5, 1fr);
    }
  `->rawCss
}

@react.component(: MovieBlockCards.props_)
let make = (~title, ~link=None, ~cards, ~showDuration=false, ~showTrailer=false) => {
  let durationCached = React.useCallback(MovieBlockCards.durationOverlay, (cards, showDuration))
  let labelOverlayCached = React.useCallback(MovieBlockCards.kindLabelOverlay, (cards, showTrailer))
  let overlays = []

  if showDuration {
    overlays->Array.push(durationCached)
  }

  if showTrailer {
    overlays->Array.push(labelOverlayCached)
  }

  <MovieBlock title link>
    <div className={Style.grid}>
      {cards->Array.map(cardData => {
        let (cardProps, previewProps) = cardData
        <MovieCard key={cardProps.id} cardProps previewProps>
          {overlays->Array.map(overlay => overlay(cardProps))->React.array}
          {switch cardProps.forceLabel {
          | Some(label) => MovieBlockCards.labelOverlay(label, cardProps.id)
          | None => React.null
          }}
        </MovieCard>
      })->React.array}
    </div>
  </MovieBlock>
}
