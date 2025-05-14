open ArteContract

external recordAsJson: 'a => Js.Json.t = "%identity"

// TODO: Add Pino Logs
let exnMsgHandler = (exn, name) =>
  `${name} Error: `->Console.log2(
    switch Js.Exn.message(exn) {
    | Some(exnMsg) => exnMsg
    | None => "No message"
    },
  )

let arteHtmlResponse = async (promiseArteData: promise<ArteData.t>) => {
  switch await promiseArteData {
  | data => data->recordAsJson->Next.NextResponse.json
  | exception htmlExn => {
      switch htmlExn {
      | ArteHtml.FetchError(exn) => exn->exnMsgHandler("Fetch")
      | ArteHtml.HtmlParsingError(msg) => "Html Parsing Error :"->Console.log2(msg)
      | S.Raised(error) => error->S.Error.message->Console.log2("ArteDataHtml Schema Error: ")
      | ArteHtml.ArteStatusError(status) => "Arte Status Error: "->Console.log2(status)
      | Exn.Error(exn) => exn->exnMsgHandler("Exn")
      | _ => "Unknown Error"->Console.log
      }
      Js.Json.null->Next.NextResponse.json(~options={status: ServerError})
    }
  }
}

module Home = {
  let get = async (params: Params.home) => ArteHtml.source.home(params)->arteHtmlResponse
}

module Live = {
  let get = async (params: Params.direct) => ArteHtml.source.direct(params)->arteHtmlResponse
}

module Video = {
  let get = async (params: Params.video) => ArteHtml.source.video(params)->arteHtmlResponse
}

module Category = {
  let get = async (params: Params.category) => ArteHtml.source.category(params)->arteHtmlResponse
}
