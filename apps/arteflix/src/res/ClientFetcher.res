// Fetcher and validation on front side
open Fetch

exception FetchError(Exn.t)
exception ParseError(S.error)

let validateArteData = text => text->S.parseJsonStringOrThrow(ArteData.schema)

// Common Fetcher Content for ArteData
let fetcher = async (validateArteData, url) => {
  try {
    let resp = await fetch(
      url,
      {
        method: #GET,
      },
    )
    let stringData = await Response.text(resp)
    stringData->validateArteData
  } catch {
  | Exn.Error(err) => raise(FetchError(err))
  }
}

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
      stringData->validate
    } catch {
    | Exn.Error(err) => raise(FetchError(err))
    }
  }
}

open FetchArte

module WillRemove = {
  let home = async (params: ArteContract.Params.home) => {
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
    ArteApi.Fetcher.home(params)
  }

  let player = (params: ArteContract.Params.video) => ArteApi.Fetcher.player(params)

  let trailer = (params: ArteContract.Params.video) => ArteApi.Fetcher.trailer(params)

  let video = (params: ArteContract.Params.video) => {
    attemptFetchers(prodFetchers.video, params)
  }

  let collection = (params: ArteContract.Params.video) => {
    attemptFetchers(prodFetchers.collection, params)
  }

  let genre = (params: ArteContract.Params.video) => {
    attemptFetchers(prodFetchers.genre, params)
  }

  let category = (params: ArteContract.Params.category) => {
    attemptFetchers(prodFetchers.category, params)
  }

  let direct = (params: ArteContract.Params.direct) => {
    attemptFetchers(prodFetchers.direct, params)
  }
}

