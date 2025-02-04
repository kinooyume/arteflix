// TODO: separate fetchHtml & fetchApi
// On peut faire un functor

// TODO: same stuff player/trailer

open ArteParser.Endpoints
open ArteApi

module Urls: ArteUrls = {
  let home = ({lang}: Params.home) =>
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/pages/HOME`
  let direct = ({lang}: Params.direct) =>
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/pages/LIVE`
  let video = ({lang, id}: Params.video) =>
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/programs/${id}`
  let category = ({lang, category, title}: Params.category) => // TODO: tmp, wrong
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/programs/${category}`
  // let player = ({lang, id}: Params.video) =>
  //   `https://api.arte.tv/api/player/v2/config/${lang}/${id}`
  // let trailer = ({lang, id}: Params.video) =>
  //   `https://api.arte.tv/api/player/v2/trailer/${lang}/${id}`
}

module Fetcher = MakeArteApi(Urls)

// Playlist
// https://api-internal.arte.tv/api/player/v2/playlist/en/111699-001-A

//
// Global stuff ? to check
//
// https://www.arte.tv/api/rproxy/emac/v4/en/web/
//
// +++ ==>
// PAGES
// https://www.arte.tv/api/rproxy/emac/v4/fr/web/pages/HOME

// Page content I think, zones quoi
// https://www.arte.tv/api/rproxy/emac/v4/en/web/programs/106711-000-A/

//fr/videos/106711-000-A/tax-wars/
//
// Api Player
//
// https://api.arte.tv/api/player/v2/config/fr/112907-091-A
//
//
// Collection
// https://www.arte.tv/api/rproxy/emac/v4/en/web/programs/106711-000-A/

// DIRECT
// https://api.arte.tv/api/player/v2/config/fr/LIVE
//

//
//
//
//
// PAS FOU:
//
// https://www.arte.tv/api/rproxy/emac/v4/fr/web/zones/bee2e20c-9485-47b6-bbfc-51fd248d265a
// pas bcp d'info
//
