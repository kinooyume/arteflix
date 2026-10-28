open ArteContract

let firstEpisodeHref = (data: ArteData.t, ~lang) =>
  VideoPageClient.buildEpisodeGroups(Some(data), Some(data), "", ~lang)
  ->Array.get(0)
  ->Option.flatMap(group => group.episodes->Array.get(0))
  ->Option.map(episode => episode.href)

type props_ = {params: Params.collection}

@react.component(: props_)
let make = (~params) => {
  let {data, error} = Swr.useSWR(ArteApiProxy.Urls.collection(params), ClientFetcher.resolvedFetcher)

  React.useEffect(() => {
    let collectionPath = Location.read().path
    switch (data, error) {
    | (Some(data), _) =>
      Location.replace(firstEpisodeHref(data, ~lang=params.lang)->Option.getOr(collectionPath))
    | (None, Some(_)) => Location.replace(collectionPath)
    | (None, None) => ()
    }
    None
  }, (data, error))

  <PageSkeleton />
}
