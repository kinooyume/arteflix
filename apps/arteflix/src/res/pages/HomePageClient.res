@@directive("'use client';")

open ArteContract
open ArteApiProxy
open ClientFetcher

type props_ = {params: Params.home}

@react.component(: props_)
let make = (~params) => {
  let {data, error} = Swr.useSWR(params->Urls.home, fetcher(validateArteData, ...))

  <>
    {switch error {
    | Some(err) =>
      Js.log(err)
      switch err {
      | FetchError(_) => <ServerError message="A fetch error occur" />
      | ParseError(_) => <ServerError message="A parsing error occur" />
      | Exn.Error(_) => <ServerError message="500 Error | Failed to fetch Arte error" />
      | _ => <ServerError message="500 Error | Failed to fetch Arte error" />
      }
    | None => React.null
    }}
    {switch data {
    | Some(arteData) =>
      <FadeIn>
        // {switch arteData.apiPlayerConfig {
        // | Some(playerConfig) => <p> {"Player"->React.string} </p>
        // | None => React.null
        // }}
        <div>
          {arteData.zones
          ->Array.map(zone =>
            <Lazyload key={zone.id} once=true height=300 offset=200>
              <Zone zone />
            </Lazyload>
          )
          ->React.array}
        </div>
      </FadeIn>
    | None => <PageSkeleton />
    }}
  </>
}
