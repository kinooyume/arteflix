@val @module("swr")
external useSWRNullable: (
  Js.Nullable.t<string>,
  SwrCommon.fetcher1<string, 'data>,
) => Swr.swrResponse<'data> = "default"

type state = Loading | Ready(ArteZone.t)

let use = (zone: ArteZone.t) => {
  let {data, error} = useSWRNullable(
    zone.content.esiInclude->Js.Nullable.fromOption,
    ClientFetcher.fetcher(ClientFetcher.validateZoneContent, ...),
  )
  switch (zone.content.esiInclude, data, error) {
  | (None, _, _) => Ready(zone)
  | (Some(_), Some(content), _) => Ready({...zone, content})
  | (Some(_), None, Some(_)) => Ready({...zone, content: {...zone.content, esiInclude: None}})
  | (Some(_), None, None) => Loading
  }
}
