open Emotion

module Style = {
  let container =
    ReactDOM.Style.make(
      ~display="flex",
      ~flexDirection="column",
      ~listStyle="none",
      ~width="100%",
      (),
    )->css
}

type props_ = {
  episodes: array<EpisodeButton.t>,
  renderImage?: EpisodeCard.renderImage,
}

@react.component(: props_)
let make = (~episodes, ~renderImage=?) => {
  <ul className={Style.container}>
    {episodes
    ->Array.mapWithIndex((episode, index) => {
      let imageSrcSet = episode.imageSrcSet
      <li key={index->Int.toString}>
        <EpisodeButton
          index={index + 1}
          id={episode.id}
          href=episode.href
          title=episode.title
          selected=episode.selected
          description=episode.description
          duration=episode.duration
          imageSrc=episode.imageSrc
          ?imageSrcSet
          imageAlt=episode.imageAlt
          ?renderImage
        />
      </li>
    })
    ->React.array}
  </ul>
}
