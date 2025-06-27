open ArteContract

module Urls = {
  let home = ({lang}: Params.home) => `/proxy/api/${lang}`
  let program = ({lang, id}: Params.program) => `/proxy/api/${lang}/program/${id}`
  let collection = ({lang, id}: Params.collection) => `/proxy/api/${lang}/collection/${id}`
  let category = ({lang, slug}: Params.category) => `/proxy/api/${lang]/page/${slug}`
  let player = ({lang, id}: Params.program) => `/proxy/api/${lang}/player/${id}`
  let playlist = ({lang, id}: Params.program) => `/proxy/api/${lang}/playlist/${id}`
  let trailer = ({lang, id}: Params.program) => `/proxy/api/${lang}/trailer/${id}`
  let live = ({lang}: Params.live) => `/proxy/api/${lang}/live`
  // let livePlayer = ({lang}: Params.live) => `/proxy/api/${lang}/player/LIVE`
}
