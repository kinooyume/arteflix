open ClientFetcher

exception NoStream

let fetchStreamUrl = async (~lang, ~id) => {
  let url = ArteApiProxy.Urls.trailer({lang, id})
  let config = await fetcher(validatePlayerData, url)
  switch config.attributes.streams->Array.get(0) {
  | Some(stream) => stream.url
  | None => raise(NoStream)
  }
}
