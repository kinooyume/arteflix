open Node

exception FetchError(Exn.t)
exception ParseError(S.error)

let fetch = async path => {
  try {
    await Fs.readFile(~path, ~encoding="utf-8")
  } catch {
  | Exn.Error(err) => raise(FetchError(err))
  }
}

// let validate = text =>
//   switch text->S.parseOrThrow(ArteDataHtml.schema) {
//   | Ok(data) => data
//   | Error(err) => raise(ParseError(err))
//   }
//
// let validate = text =>text->S.parseOrThrow(ArteDataHtml.schema)
//
// let transform = (data: ArteDataHtml.t): ArteData.t => {
//   content: {
//     zones: data.props.pageProps.props.page.value.zones,
//     parent: data.props.pageProps.props.parent,
//     metadata: data.props.pageProps.props.metadata,
//   },
//   apiPlayerConfig: data.props.pageProps.props.apiPlayerConfig,
//
//   // ->ArteData.toJson
//   // ->JSONUtils.stripUndefined
//   // ->ArteData.fromJson
// }

// let get = async (~path) => {
//   let stringData = await fetch(path)
//   let data = validate(stringData)
//   transform(data)
// }
//
// let endpoints: ArteContract.t = {
//   home: async _ => {
//     await get(~path="./mockups/arteHome2.json")
//   },
//   direct: async _ => {
//     await get(~path="./mockups/arteDirect.json")
//   },
//   video: async _ => {
//     await get(~path="./mockups/arteVideo.json")
//   },
//   category: async _ => {
//     await get(~path="./mockups/arteHome2.json")
//   },
// }
