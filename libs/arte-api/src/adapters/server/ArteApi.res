open Fetch
open ArteContract

exception NextDataError(string)
exception FetchError(Exn.t)
exception ParseError(S.error)

module Urls = {
  let home = ({lang}: Params.home) =>
    `https://api-cdn.arte.tv/api/emac/v4/${lang}/web/pages/HOME`
  let category = (lang: string, code: string) =>
    `https://api-cdn.arte.tv/api/emac/v4/${lang}/web/pages/${code}`
  let program = ({lang, id}: Params.program) =>
    `https://api-cdn.arte.tv/api/emac/v4/${lang}/web/programs/${id}`
  let collection = ({lang, id}: Params.collection) =>
    `https://api-cdn.arte.tv/api/emac/v4/${lang}/web/collections/${id}`
  let player = ({lang, id}: Params.player) =>
    `https://api.arte.tv/api/player/v2/config/${lang}/${id}`
  let trailer = ({lang, id}: Params.player) =>
    `https://api.arte.tv/api/player/v2/trailer/${lang}/${id}`
  let playlist = ({lang, id}: Params.player) =>
    `https://api.arte.tv/api/player/v2/playlist/${lang}/${id}`
  let live = ({lang}: Params.live) =>
    `https://api-cdn.arte.tv/api/emac/v4/${lang}/web/pages/LIVE`
}

module Gateway = {
  let validateArteData = text => text->S.parseJsonStringOrThrow(ArteData.schema)
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
    | S.Error(e) => raise(ParseError(e))
    | Exn.Error(err) => raise(FetchError(err))
    }
  }

  let contentFetcher = fetcher(validateArteData, ...)
  let playerFetcher = fetcher(validatePlayerData, ...)
}

module Fetcher = {
  let home = async (params: Params.home) => {
    let url = Urls.home(params)
    await Gateway.contentFetcher(url)
  }

  let live = async (params: Params.live) => {
    let url = Urls.live(params)
    await Gateway.contentFetcher(url)
  }

  let program = async (params: Params.program) => {
    let contentUrl = params->Urls.program
    await Gateway.contentFetcher(contentUrl)
  }

  let collection = async (params: Params.collection) => {
    let contentUrl = params->Urls.collection
    await Gateway.contentFetcher(contentUrl)
  }

  let category = async (~resolveCategory, {lang, slug}: Params.category) => {
    let code = switch resolveCategory(lang, slug) {
    | Some(code) => code
    | None => raise(NextDataError("No routes found for the given language and slug"))
    }
    let contentUrl = Urls.category(lang, code)
    await Gateway.contentFetcher(contentUrl)
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
