open ArteParser.Endpoints

external recordAsJson: 'a => Js.Json.t = "%identity"

// TODO: Add Exception Logs
module Home = {
  let get = async (params: Params.home) => {
    await (
      switch await ArteApiSource.Fetcher.home(params) {
      | data => data->recordAsJson->Next.NextResponse.json
      | exception _ => Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
      }
    )
  }
}

module Player = {
  let get = async (params: Params.video) => {
    switch await ArteApiSource.Fetcher.player(params) {
    | config => config->recordAsJson->Next.NextResponse.json
    | exception _ => Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
    }
  }
}

module Trailer = {
  let get = async (params: Params.video) => {
    switch await ArteApiSource.Fetcher.trailer(params) {
    | config => config->recordAsJson->Next.NextResponse.json
    | exception _ => Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
    }
  }
}
