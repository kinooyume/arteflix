open ClientFetcher
open ArteApiProxy

let defaultOptions: VideoJs.playerOptions = {
  controls: true,
  preload: #auto,
  fluid: false,
}

type props_ = {
  id: string,
  lang: string,
  episodes?: array<NetflixMode.episodeGroup>,
  onEpisodeSelect?: NetflixMode.episode => unit,
}
@react.component(: props_)
let make = (~id, ~lang, ~episodes=?, ~onEpisodeSelect=?) => {
  let {data, error} = Swr.useSWR(
    Urls.player({id, lang}),
    fetcher(validatePlayerData, ...),
  )
  let prevDataRef = React.useRef(None)
  let effectiveData = switch data {
  | Some(_) as d =>
    prevDataRef.current = d
    d
  | None => prevDataRef.current
  }
  let (player, setPlayer) = React.useState(() => Js.Nullable.null)

  <>
    {switch error {
    | Some(err) =>
      switch err {
      | ClientFetcher.FetchError(_) => <ServerError message="Can't fetch video" />
      | ClientFetcher.ParseError(_) => <ServerError message="Can't fetch video" />
      | Exn.Error(_) => <ServerError message="500 Error | Can't fetch video | Unhandle" />
      | _ => <ServerError message="500 Error | Can't fetch video" />
      }
    | None => React.null
    }}
    {switch effectiveData {
    | Some(playerConfig) =>
      switch playerConfig.attributes.streams->Array.get(0) {
      | Some(stream) => {
          let options = switch playerConfig.attributes.autoplay {
          | true => {...defaultOptions, autoplay: #any}
          | false => defaultOptions
          }
          let currentEpisode =
            episodes->Option.flatMap(groups =>
              groups->Array.findMap(g => g.episodes->Array.find(e => e.selected))
            )
          let metadataTitle = playerConfig.attributes.metadata.title
          let (overlayTitle, overlaySubtitle, controlBarTitle, controlBarSubtitle) =
            switch currentEpisode {
            | Some({subtitle: Some(sub), title}) => (
                title,
                Some(sub),
                title,
                Some(sub),
              )
            | Some({title}) => (title, None, title, None)
            | None => (metadataTitle, None, metadataTitle, None)
            }
          let subtitle = overlaySubtitle
          let description = Some(playerConfig.attributes.metadata.description)
          <div style={ReactDOM.Style.make(~position="relative", ~width="100%", ~height="100dvh", ())}>
            <Player
              url={stream.url}
              options
              onPlayer={p => setPlayer(_ => Js.Nullable.Value(p))}
              title={controlBarTitle}
              subtitle=?controlBarSubtitle
              ?episodes
              ?onEpisodeSelect
            />
            <PlayerOverlay
              player
              title={overlayTitle}
              ?subtitle
              ?description
            />
          </div>
        }
      | None => <p> {"No Stream"->React.string} </p>
      }
    | None =>
      <div style={ReactDOM.Style.make(~width="100%", ~height="100dvh", ~background="#141414", ())} />
    }}
  </>
}
