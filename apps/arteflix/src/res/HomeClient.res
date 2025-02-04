@@directive("'use client';")

// @react.component(: ArteData.t)
// let make = (~content, ~apiPlayerConfig) =>

open ArteParser.Endpoints
open ArteApiProxy

type props_ = {params: Params.home}

@react.component(: props_)
let make = (~params) => {
  let {data, error} = Swr.useSWR(params->Urls.home, ClientFetcher.Html.fetcher)

  <>
    {switch error {
    | Some(err) =>
        Js.log(err)
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
        {switch arteData.apiPlayerConfig {
        | Some(playerConfig) => <p> {"Player"->React.string} </p>
        | None => React.null
        }}
        <div>
          {arteData.content.zones
          ->Array.map(zone =>
            <Lazyload key={zone.id} once=true height=300 offset=200>
              <Zone zone />
            </Lazyload>
          )
          ->React.array}
        </div>
      </>
    | None => React.null
    }}
  </>
}
