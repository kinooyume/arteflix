open ArteContract

external recordAsJson: 'a => Js.Json.t = "%identity"

let home = async (params: Params.home) => {
  switch await ArteApi.Fetcher.home(params) {
  | data => data->recordAsJson->Next.NextResponse.json
  | exception e =>
    Console.error2("[Proxy] home error:", e)
    Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
  }
}

let program = async (params: Params.program) => {
  switch await ArteApi.Fetcher.program(params) {
  | data => data->recordAsJson->Next.NextResponse.json
  | exception e =>
    Console.error2("[Proxy] program error:", e)
    Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
  }
}

let collection = async (params: Params.collection) => {
  switch await ArteApi.Fetcher.collection(params) {
  | data => data->recordAsJson->Next.NextResponse.json
  | exception e =>
    Console.error2("[Proxy] collection error:", e)
    Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
  }
}

let category = async (params: Params.categoryPage) => {
  let slug =
    params.slug
    ->Array.map(s => s->String.split(","))
    ->Array.flat
    ->Array.join("/")

  let p: Params.category = {
    lang: params.lang,
    slug,
  }
  switch await ArteApi.Fetcher.category(p) {
  | data => data->recordAsJson->Next.NextResponse.json
  | exception e =>
    Console.error2("[Proxy] category error:", e)
    Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
  }
}

let player = async (params: Params.player) => {
  switch await ArteApi.Fetcher.player(params) {
  | data => data->recordAsJson->Next.NextResponse.json
  | exception e =>
    Console.error2("[Proxy] player error:", e)
    Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
  }
}
