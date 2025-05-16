@@directive("'use client';")

// @react.component(: ArteData.t)
// let make = (~content, ~apiPlayerConfig) =>

open ArteContract
open ClientFetcher
open ArteApiProxy

type props_ = {params: Params.category}
@react.component(: props_)
let make = (~params) => {
  let {data, error} = Swr.useSWR(params->Urls.category, fetcher(validateArteData, ...))

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
          {arteData.zones
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
