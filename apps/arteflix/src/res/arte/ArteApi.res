open Fetch

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
    let content = await Content.fetcher(url)
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

