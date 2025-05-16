open ArteContract

external recordAsJson: 'a => Js.Json.t = "%identity"

// TODO: implement Pino Logs
let home = async (params: Params.home) => {
  switch await ArteApi.Fetcher.home(params) {
  | data => data->recordAsJson->Next.NextResponse.json
  | exception _ => Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
  }
}

let program = async (params: Params.program) => {
  switch await ArteApi.Fetcher.program(params) {
  | data => data->recordAsJson->Next.NextResponse.json
  | exception _ => Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
  }
}

let collection = async (params: Params.collection) => {
  switch await ArteApi.Fetcher.collection(params) {
  | data => data->recordAsJson->Next.NextResponse.json
  | exception _ => Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
  }
}

let category = async (params: Params.category) => {
  switch await ArteApi.Fetcher.category(params) {
  | data => data->recordAsJson->Next.NextResponse.json
  | exception _ => Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
  }
}

let player = async (params: Params.player) => {
  switch await ArteApi.Fetcher.player(params) {
  | data => {
    Js.log2("Player data: ", data)
    data->recordAsJson->Next.NextResponse.json
  }
  | exception _ => Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
  }
}
