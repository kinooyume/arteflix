@@directive("'use client';")

// NOTE: same as Videojclient, but different call
// and different behavior, will see
open ArteParser.Endpoints

let defaultOptions: VideoJs.playerOptions = {
  controls: true,
  preload: #auto,
  fluid: false,
}

let makePlayer = (~playerConfig: ArtePlayerConfig.t) => {
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
}

open ArteApiProxy
// Bon, pour video/collection; on va séparer le -A, et fallback au cas ou
@react.component
let make = (~params: Params.direct) => {
  // TODO: check for multiple swr
  // let playerConfig = Swr.useSWR(params, SwrFetcher.player)
  let {data, error} = Swr.useSWR(params->Urls.direct, ClientFetcher.Html.fetcher)

  // {switch playerConfig.data {
  // | Some(playerConfig) => makePlayer(~playerConfig)
  // | None => React.null
  // }}
  //

  <>
    {switch error {
    | Some(err) =>
      switch err {
      | ClientFetcher.FetchError(_) => <ServerError message="A fetch error occur" />
      | ClientFetcher.ParseError(_) => <ServerError message="A parsing error occur" />
      | Exn.Error(_) => <ServerError message="500 Error | Failed to fetch Arte error" />
      | _ => <ServerError message="500 Error | Failed to fetch Arte error" />
      }
    | None => React.null
    }}
    {switch data {
    | Some(arteData) =>
      <>
        <div>
          {arteData.content.zones
          ->Array.map(zone =>
            <Lazyload key={zone.id} once=true height=300 offset=200>
              <ZoneVideo
                id="direct"
                zone
                playerConfig={arteData.apiPlayerConfig}
                metadata={arteData.content.metadata}
                parent={arteData.content.parent}
              />
            </Lazyload>
          )
          ->React.array}
        </div>
      </>
    | None => React.null
    }}
  </>
}
