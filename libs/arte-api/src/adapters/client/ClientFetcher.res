open Fetch

exception FetchError(Exn.t)
exception ParseError(S.error)

let validateArteData = text => text->S.parseJsonStringOrThrow(ArteData.schema)
let validatePlayerData = text => text->S.parseJsonStringOrThrow(ArtePlayerConfig.schema)
let validateZoneContent = text => text->S.parseJsonStringOrThrow(ArteZone.zoneContentSchema)

let fetcher = async (validate, url) => {
  try {
    let resp = await fetch(
      url,
      {
        method: #GET,
      },
    )
    let stringData = await Response.text(resp)
    stringData->validate
  } catch {
  | S.Error(e) => raise(ParseError(e))
  | Exn.Error(err) => raise(FetchError(err))
  }
}

let resolveZone = async (zone: ArteZone.t) =>
  switch zone.content.esiInclude {
  | Some(url) =>
    switch await fetcher(validateZoneContent, url) {
    | content => {...zone, content}
    | exception e =>
      Console.warn3("[ClientFetcher] zone dropped:", zone.id, e)
      {...zone, content: {...zone.content, esiInclude: None}}
    }
  | None => zone
  }

let resolvedFetcher = async url => {
  let data: ArteData.t = await fetcher(validateArteData, url)
  {...data, zones: await data.zones->Array.map(resolveZone)->Promise.all}
}
