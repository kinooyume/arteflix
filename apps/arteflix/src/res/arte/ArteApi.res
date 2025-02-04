open Fetch

exception NextDataError(string)
exception FetchError(Exn.t)
exception ParseError(S.error)
exception MockupError(Exn.t)

let fetch = async (~url) => {
  try {
    let resp = await fetch(
      url,
      {
        method: #GET,
      },
    )
    await Response.text(resp)
  } catch {
  | Exn.Error(err) => raise(FetchError(err))
  }
}

// NOTE: Content / PlayerConfig ==> different schema in validate
// ==> C'est tout

module Content = {
  // Donc, validate aussi utilisé en front
  // let validate = text =>
  //   switch text->S.parseOrThrow(ArteDataApi.contentSchema) {
  //   | Ok(data) => data
  //   | Error(err) => raise(ParseError(err))
  //   }
  let validate = text =>text->S.parseOrThrow(ArteDataApi.contentSchema)

  let get = async (~url) => {
    let stringData = await fetch(~url)
    validate(stringData)
  }
}

module PlayerConfig = {
  let validate = text => text->S.parseOrThrow(ArteDataApi.playerSchema)
  // let validate = text =>
  //   switch text->S.parseOrThrow(ArteDataApi.playerSchema) {
  //   | Ok(data) => data
  //   | Error(err) => raise(ParseError(err))
  //   }

  let get = async (~url) => {
    let stringData = await fetch(~url)
    validate(stringData)
  }
}

open ArteParser.Endpoints

module type ArteUrls = {
  let home: Params.home => string
  let direct: Params.direct => string
  let video: Params.video => string
  let category: Params.category => string

  // let collection: string

  // let genre: string
  // let category: string

  // let player: Params.video => string
  // let trailer: Params.video => string
}

module MakeArteApi = (Urls: ArteUrls) => {
// TODO: home not needed as we don't have apiPlayerConfig
  let home = async (queries: Params.home) => {
    let url = Urls.home(queries)
    Js.log2("ArteApi", url)
    let content = await Content.get(~url)
    Js.log2("Content", content)
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
  let video = async (queries: Params.video) => {
    let contentUrl = queries->Urls.video
    // let playerUrl = queries->Urls.player
    let playerUrl = "TMP urls player"
    let content = await Content.get(~url=contentUrl)
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

  let player = async (queries: ArteParser.Endpoints.Params.video): ArteData.t => {
    // let playerUrl = queries->Urls.player
    let playerUrl = "TMP urls player"
    let playerConfig = await PlayerConfig.get(~url=playerUrl)
    {
      content: ArteData.contentPlaceholder,
      apiPlayerConfig: Some(playerConfig.data),
    }
  }

  let trailer = async (queries: ArteParser.Endpoints.Params.video): ArteData.t => {
    // let playerUrl = queries->Urls.trailer
    let playerUrl = "TMP urls player"

    let playerConfig = await PlayerConfig.get(~url=playerUrl)
    {
      content: ArteData.contentPlaceholder,
      apiPlayerConfig: Some(playerConfig.data),
    }
  }
}
