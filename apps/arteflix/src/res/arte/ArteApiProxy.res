open ArteParser.Endpoints
open ArteApi

// NOTE: Normalement au meme endroit que ArteApiSource
// ==> juste checker si tree-shakeable marche bien

// ProxyParams ?
module Urls: ArteUrls = {
  let home = ({lang}: Params.home) => `/proxy/api/${lang}`
  let direct = ({lang}: Params.direct) => `/proxy/html/${lang}/live`
  let video = ({lang, id}: Params.video) => {
    `/proxy/html/${lang}/videos/${id}`
  }
  // NOTE: we probably want to make two different routes
  let category = ({lang, category, title}: Params.category) =>
    switch title {
    | Some(t) => `/proxy/html/${lang}/${category}/${t}`
    | None => `/proxy/html/${lang}/${category}`
    }

  // let player = ({lang, id}: Params.video) => {
  //   `/proxy/html/${lang}/player/${id}`
  // }
  // let trailer = ({lang, id}: Params.video) => {
  //   `/proxy/html/${lang}/trailer/${id}`
  // }
}
