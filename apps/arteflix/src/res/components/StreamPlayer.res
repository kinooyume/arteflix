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
          <Player url={stream.url} options />
        }
      | None => <p> {"No Stream"->React.string} </p> // TODO: Handler Error no Stream
      }
    | None => React.null
    }}
  </>
}
