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
      let url = params->Urls.home
      Console.error3("[HomePageClient]", url, err)
      switch err {
      | FetchError(e) => <ServerError message={`Fetch error on ${url}: ${e->Exn.message->Option.getOr("unknown")}`} />
      | ParseError(e) => <ServerError message={`Parse error on ${url}: ${e.message}`} />
      | Exn.Error(e) => <ServerError message={`Error on ${url}: ${e->Exn.message->Option.getOr("unknown")}`} />
      | _ => <ServerError message={`Unknown error on ${url}`} />
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
