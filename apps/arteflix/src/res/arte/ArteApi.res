open Fetch
open ArteContract

exception NextDataError(string)
exception FetchError(Exn.t)
exception ParseError(S.error)
exception MockupError(Exn.t)

module Urls = {
  let home = ({lang}: Params.home) =>
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/pages/HOME`
  let category = (lang: string, code: string) =>
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/pages/${code}`
  let program = ({lang, id}: Params.program) =>
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/programs/${id}`
  let collection = ({lang, id}: Params.collection) =>
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/collections/${id}`
  let player = ({lang, id}: Params.player) =>
    `https://api.arte.tv/api/player/v2/config/${lang}/${id}`
  let trailer = ({lang, id}: Params.player) =>
    `https://api.arte.tv/api/player/v2/trailer/${lang}/${id}`
  let playlist = ({lang, id}: Params.player) =>
    `https://api.arte.tv/api/player/v2/playlist/${lang}/${id}`
  let live = ({lang}: Params.live) =>
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/pages/LIVE`
}

module Gateway = {
  let validateArteData = text => text->S.parseJsonStringOrThrow(ArteDataApi.contentSchema)
  let validatePlayerData = text => text->S.parseJsonStringOrThrow(ArteDataApi.playerSchema)

  @val external cachedFetch: (string, {..}) => promise<Response.t> = "fetch"

  let fetcher = async (validate, url) => {
    try {
      let resp = await cachedFetch(
        url,
        {"method": "GET", "next": {"revalidate": 60}},
      )
      let stringData = await Response.text(resp)
      stringData->validate
    } catch {
    | Exn.Error(err) => raise(FetchError(err))
    }
  }

  let contentFetcher = fetcher(validateArteData, ...)
  let playerFetcher = fetcher(validatePlayerData, ...)
}

module Fetcher = {
  let home = async (params: Params.home) => {
    let url = Urls.home(params)
    let content = await Gateway.contentFetcher(url)
    content.value
  }

  let live = async (params: Params.live) => {
    let url = Urls.live(params)
    let content = await Gateway.contentFetcher(url)
    content.value
  }

  let program = async (params: Params.program) => {
    let contentUrl = params->Urls.program
    let content = await Gateway.contentFetcher(contentUrl)

    content.value
  }

  let collection = async (params: Params.collection) => {
    let contentUrl = params->Urls.collection
    let content = await Gateway.contentFetcher(contentUrl)

    content.value
  }

  let category = async ({lang, slug}: Params.category) => {
    let slugList = slug->String.split("/")->List.fromArray
    let code = switch ArteRoutesData.routes->Dict.get(lang) {
    | Some(data) =>
      switch data->ArteRoutesData.findPage(slugList) {
      | Some(page) => page.code
      | None => ""
      }
    | None => raise(NextDataError("No routes found for the given language"))
    }
    let contentUrl = Urls.category(lang, code)
    let content = await Gateway.contentFetcher(contentUrl)
    content.value
  }


  let player = async (params: Params.player) => {
    let contentUrl = params->Urls.player
    let content = await Gateway.playerFetcher(contentUrl)
    content.data
  }

  let trailer = async (params: ArteContract.Params.program) => {
    // let playerUrl = params->Urls.trailer
    let playerUrl = "TMP urls player"

    // let playerConfig = await PlayerConfig.get(~url=playerUrl)

    // {
    //   content: ArteData.contentPlaceholder,
    //   apiPlayerConfig: Some(playerConfig.data),
    // }
    ArteData.contentPlaceholder
  }
}

// Source pour Arte

// https://api.arte.tv/api/player/v2/config/en/PNE0226

// Playlist
// https://api-internal.arte.tv/api/player/v2/playlist/en/111699-001-A

//
// Global stuff ? to check
// NOTE: Ouai donc on va avoir besoins de ça coté back, pour faire le liens avec les category
// ==> Donc "malheureusement", on va le garder en fix
// ==> Sinon, ça va etre long de faire double requete
//
// https://www.arte.tv/api/rproxy/emac/v4/en/web/
//
// +++ ==>
// PAGES
// https://www.arte.tv/api/rproxy/emac/v4/fr/web/pages/HOME

// Category

// https://www.arte.tv/api/rproxy/emac/v4/en/web/pages/CIN
// --> CIN for cinema
// Page content I think, zones quoi
// https://www.arte.tv/api/rproxy/emac/v4/en/web/programs/106711-000-A/

// RC-023234
//fr/videos/106711-000-A/tax-wars/
//
// Api Player
// https://api.arte.tv/api/player/v2/config/fr/112907-091-A
//

// Videos
// https://www.arte.tv/api/rproxy/emac/v4/en/web/programs/106711-000-A/

// Collection ·
// https://www.arte.tv/api/rproxy/emac/v4/fr/web/collections/RC-023234/
//

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
// https://github.com/mediathekview/MServer/blob/7e9ed640f06394b2f0cae518e047d31ae4bccfb1/src/main/java/mServer/crawler/sender/arte/MediathekArte.java#L21
//
// https://github.com/yt-dlp/yt-dlp/issues/1059#issuecomment-1784161057
//
// OPA v3 (HbbTV) — programs by date
// https://www.arte.tv/hbbtvv2/services/web/index.php/OPA/v3/programs/19-02-2026/fr
