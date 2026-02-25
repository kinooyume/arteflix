// Fetcher and validation on front side
open Fetch

exception FetchError(Exn.t)
exception ParseError(S.error)

let validateArteData = text => text->S.parseJsonStringOrThrow(ArteData.schema)
let validatePlayerData = text => text->S.parseJsonStringOrThrow(ArtePlayerConfig.schema)

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
