type entry<'a> = {
  value: 'a,
  expiresAt: float,
}

type t = {
  store: Dict.t<entry<Js.Json.t>>,
  ttl: float,
}

@val external dateNow: unit => float = "Date.now"

external toJson: 'a => Js.Json.t = "%identity"
external fromJson: Js.Json.t => 'a = "%identity"

let make = (~ttl) => {
  store: Dict.make(),
  ttl: ttl->Int.toFloat,
}

let getOrFetch = async (cache, key, fetcher) => {
  let now = dateNow()
  switch cache.store->Dict.get(key) {
  | Some(entry) if entry.expiresAt > now => entry.value->fromJson
  | _ => {
      let value = await fetcher()
      cache.store->Dict.set(key, {value: value->toJson, expiresAt: now +. cache.ttl})
      value
    }
  }
}

let invalidate = (cache, key) => {
  cache.store->Dict.delete(key)
}

let invalidateAll = cache => {
  cache.store->Dict.keysToArray->Array.forEach(key => cache.store->Dict.delete(key))
}
