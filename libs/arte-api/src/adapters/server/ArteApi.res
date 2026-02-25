open Fetch
open ArteContract

exception NextDataError(string)
exception FetchError(Exn.t)
exception ParseError(S.error)


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

  let category = async (~resolveCategory, {lang, slug}: Params.category) => {
    let code = switch resolveCategory(lang, slug) {
    | Some(code) => code
    | None => raise(NextDataError("No routes found for the given language and slug"))
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

  let trailer = async (params: Params.player) => {
    let contentUrl = params->Urls.trailer
    let content = await Gateway.playerFetcher(contentUrl)
    content.data
  }
}
