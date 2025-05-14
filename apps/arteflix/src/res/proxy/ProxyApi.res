open ArteContract

external recordAsJson: 'a => Js.Json.t = "%identity"

// NOTE: Appelé par le proxy
// ==>  ArteApi Fetcher -> ArteApi
//
// NOTE: ce qu'on veut mocké, c'est cette partie là en fait
// Donc balleks
//
// TODO: implement Pino Logs

let home = async (params: Params.home) => {
  switch await ArteApi.Fetcher.home(params) {
  | data => data->recordAsJson->Next.NextResponse.json
  | exception _ => Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
  }
}

let video = async (params: Params.video) => {
  switch await ArteApi.Fetcher.video(params) {
  | data => data->recordAsJson->Next.NextResponse.json
  | exception _ => Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
  }
}

module Player = {
  let get = async (params: Params.video) => {
    switch await ArteApi.Fetcher.player(params) {
    | config => config->recordAsJson->Next.NextResponse.json
    | exception _ => Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
    }
  }
}

module Trailer = {
  let get = async (params: Params.video) => {
    switch await ArteApi.Fetcher.trailer(params) {
    | config => config->recordAsJson->Next.NextResponse.json
    | exception _ => Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
    }
  }
}
