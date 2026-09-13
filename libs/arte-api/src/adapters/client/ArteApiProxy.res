open ArteContract

let emac = "https://api-cdn.arte.tv/api/emac/v4"

module Urls = {
  let page = (lang, code) => `${emac}/${lang}/web/pages/${code}?bypassESI=true`
  let home = ({lang}: Params.home) => page(lang, "HOME")
  let live = ({lang}: Params.live) => page(lang, "LIVE")
  let program = ({lang, id}: Params.program) => `${emac}/${lang}/web/programs/${id}?bypassESI=true`
  let collection = ({lang, id}: Params.collection) =>
    `${emac}/${lang}/web/collections/${id}?bypassESI=true`
  let player = ({lang, id}: Params.program) => `/proxy/api/${lang}/player/${id}`
  let playlist = ({lang, id}: Params.program) => `/proxy/api/${lang}/playlist/${id}`
  let trailer = ({lang, id}: Params.program) => `/proxy/api/${lang}/trailer/${id}`
}
