open Fetch
open ArteContract

module Urls = {
  let home = ({lang}: Params.home) =>
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/pages/HOME`
  let direct = ({lang}: Params.direct) =>
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/pages/LIVE`

    // /video/
  let programs = ({lang, id}: Params.video) =>
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/programs/${id}`
  let collection = ({lang, id}: Params.collection) =>
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/collections/${id}`

  let category = ({lang, category}: Params.category) =>
    // TODO: tmp, wrong
    `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/programs/${category}`
  let player = ({lang, id}: Params.video) =>
    `https://api.arte.tv/api/player/v2/config/${lang}/${id}`

  // let trailer = ({lang, id}: Params.video) =>
  //   `https://api.arte.tv/api/player/v2/trailer/${lang}/${id}`
}

exception NextDataError(string)
exception FetchError(Exn.t)
exception ParseError(S.error)
exception MockupError(Exn.t)

// NOTE: Content / PlayerConfig ==> different schema in validate
// ==> C'est tout

module Content = {
  let validate = text => text->S.parseJsonStringOrThrow(ArteDataApi.contentSchema)

  let fetcher = async (url): ArteDataApi.content => {
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
    | Exn.Error(err) => raise(FetchError(err))
    }
  }
}

module PlayerConfig = {
  let validate = text => text->S.parseOrThrow(ArteDataApi.playerSchema)

  let get = async (~url) => {
    let stringData = await fetch(
      url,
      {
        method: #GET,
      },
    )
    validate(stringData)
  }
}

// TODO: remove apiPlayerConfig, only used with html
module Fetcher = {
  let home = async (queries: Params.home) => {
    let url = Urls.home(queries)
    let content = await Content.fetcher(url)
    let data: ArteData.t = {
      content: content.value,
      apiPlayerConfig: None,
    }
    data
  }

  let direct = async (queries: Params.direct) => {
    let url = Urls.direct(queries)

    let playerConfig = await PlayerConfig.get(~url)
    let data: ArteData.t = {
      content: ArteData.contentPlaceholder,
      apiPlayerConfig: Some(playerConfig.data),
    }
    data
  }

  // NOTE: Video, catalogue, category
  let video = async (queries: Params.video) => {
    //     if queries.id->String.includes("-A") {
    //       // video
    //     } else if queries.id->String.includes("RC-") {
    // // collections
    //     } else {
    //       // category
    //     }
    let contentUrl = queries->Urls.programs
    // let playerUrl = queries->Urls.player
    let playerUrl = "TMP urls player"
    let content = await Content.fetcher(contentUrl)
    let playerConfig = await PlayerConfig.get(~url=playerUrl)

    let data: ArteData.t = {
      content: content.value,
      apiPlayerConfig: Some(playerConfig.data),
    }
    data
  }
  // TODO: Implement
  let category = async _ => {
    let empty: ArteData.t = {
      content: ArteData.contentPlaceholder,
      apiPlayerConfig: None,
    }
    empty
  }

  let player = async (queries: ArteContract.Params.video): ArteData.t => {
    // let playerUrl = queries->Urls.player
    let playerUrl = "TMP urls player"
    let playerConfig = await PlayerConfig.get(~url=playerUrl)
    {
      content: ArteData.contentPlaceholder,
      apiPlayerConfig: Some(playerConfig.data),
    }
  }

  let trailer = async (queries: ArteContract.Params.video): ArteData.t => {
    // let playerUrl = queries->Urls.trailer
    let playerUrl = "TMP urls player"

    let playerConfig = await PlayerConfig.get(~url=playerUrl)
    {
      content: ArteData.contentPlaceholder,
      apiPlayerConfig: Some(playerConfig.data),
    }
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
