open ArteContract
open ClientFetcher
open ArteApiProxy

let defaultOptions: VideoJs.playerOptions = {
  controls: true,
  preload: #auto,
  fluid: false,
}

type props_ = Params.player
@react.component(: props_)
let make = (~id, ~lang) => {
  let {data, error} = Swr.useSWR(Urls.player({id, lang}), fetcher(validatePlayerData, ...))
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
    {switch data {
    | Some(playerConfig) =>
      switch playerConfig.attributes.streams->Array.get(0) {
      | Some(stream) => {
          let options = switch playerConfig.attributes.autoplay {
          | true => {...defaultOptions, autoplay: #any}
          | false => defaultOptions
          }
          <div style={ReactDOM.Style.make(~position="relative", ~width="100%", ~height="100dvh", ())}>
            <Player
              url={stream.url}
              options
              onPlayer={p => setPlayer(_ => Js.Nullable.Value(p))}
              title={playerConfig.attributes.metadata.title}
            />
            <PlayerOverlay
              player
              title={playerConfig.attributes.metadata.title}
              subtitle={playerConfig.attributes.metadata.description}
            />
          </div>
        }
      | None => <p> {"No Stream"->React.string} </p>
      }
    | None => React.null
    }}
  </>
}
