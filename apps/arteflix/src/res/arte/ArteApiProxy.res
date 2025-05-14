// NOTE: move, ça concerne le proxy
open ArteContract

module Urls = {
  let home = ({lang}: Params.home) => `/proxy/api/${lang}`
  let direct = ({lang}: Params.direct) => `/proxy/html/${lang}/live`
  let video = ({lang, id}: Params.video) => {
    `/proxy/api/${lang}/videos/${id}`
  }
  // NOTE: we probably want to make two different routes
  let category = ({lang, category, title}: Params.category) =>
    switch title {
    | Some(t) => `/proxy/api/${lang}/${category}/${t}`
    | None => `/proxy/api/${lang}/${category}`
    }

  // let player = ({lang, id}: Params.video) => {
  //   `/proxy/html/${lang}/player/${id}`
  // }
  // let trailer = ({lang, id}: Params.video) => {
  //   `/proxy/html/${lang}/trailer/${id}`
  // }
}
