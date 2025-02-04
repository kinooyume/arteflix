// Fetcher and validation on front side
open Fetch

exception FetchError(Exn.t)
exception ParseError(S.error)

module Html = {

  let validate = text => text->S.parseJsonStringOrThrow(ArteData.schema)

  // Common Fetcher Content for ArteData
  let fetcher = async (url): ArteData.t => {
    try {
      let resp = await fetch(
        url,
        {
          method: #GET,
        },
      )
      let stringData = await Response.text(resp)
      // Js.log2("fetcher:", stringData)
      stringData->validate
    } catch {
    | Exn.Error(err) => raise(FetchError(err))
    }
  }
}

open FetchArte

// NOTE: En fait pas forcément

module WillRemove = {
  let home = async (params: ArteParser.Endpoints.Params.home) => {
    // je voudrais que ça soit server
    // attemptFetchers(prodFetchers.home, params)
    // let lang = switch params.lang {
    //   | Some(lang) => lang
    //   | None => "en"
    // }
    // try {
    //   let resp = await fetch(`proxy/${lang}/home`, {
    //     method: #POST,
    //   })
    //   await Response.text(resp)
    // } catch {
    // | Exn.Error(err) => raise(FetchError(err))
    // }
    Js.log2("ClientFetcher", params)
    ArteApiSource.Fetcher.home(params)
  }

  let player = (params: ArteParser.Endpoints.Params.video) => ArteApiSource.Fetcher.player(params)

  let trailer = (params: ArteParser.Endpoints.Params.video) => ArteApiSource.Fetcher.trailer(params)

  let video = (params: ArteParser.Endpoints.Params.video) => {
    attemptFetchers(prodFetchers.video, params)
  }

  let collection = (params: ArteParser.Endpoints.Params.video) => {
    attemptFetchers(prodFetchers.collection, params)
  }

  let genre = (params: ArteParser.Endpoints.Params.video) => {
    attemptFetchers(prodFetchers.genre, params)
  }

  let category = (params: ArteParser.Endpoints.Params.category) => {
    attemptFetchers(prodFetchers.category, params)
  }

  let direct = (params: ArteParser.Endpoints.Params.direct) => {
    attemptFetchers(prodFetchers.direct, params)
  }
}
