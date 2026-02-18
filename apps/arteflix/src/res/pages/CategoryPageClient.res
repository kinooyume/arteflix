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
      let url = params->Urls.category
      Console.error3("[CategoryPageClient]", url, err)
      switch err {
      | ClientFetcher.FetchError(e) => <ServerError message={`Fetch error on ${url}: ${e->Exn.message->Option.getOr("unknown")}`} />
      | ClientFetcher.ParseError(e) => <ServerError message={`Parse error on ${url}: ${e.message}`} />
      | Exn.Error(e) => <ServerError message={`Error on ${url}: ${e->Exn.message->Option.getOr("unknown")}`} />
      | _ => <ServerError message={`Unknown error on ${url}`} />
      }
    | None => React.null
    }}
    {switch data {
    | Some(arteData) =>
      <FadeIn>
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
