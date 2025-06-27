open Fetch

exception FetchError(Exn.t)
exception ParseError(string)

let langs = ["fr", "de", "en", "es", "pl", "it"]
let arteWebUrl = lang => `https://www.arte.tv/api/rproxy/emac/v4/${lang}/web/`

let getArtePageByLang = async lang => {
  try {
    let resp = await fetch(
      lang->arteWebUrl,
      {
        method: #GET,
      },
    )
    let stringData = await Response.text(resp)
    stringData->S.parseJsonStringOrThrow(ArtePages.schema)
  } catch {
  | Exn.Error(err) => raise(FetchError(err))
  | S.Error(err) =>
    raise(ParseError(err.message))
  }
}

open ArteRoutes

let rec findlangRoutes = (routes: ArteRoutes.route, lang: string) => {
  switch routes.children {
  | Some(children) =>
    switch children->Dict.get(lang) {
    | Some(route) => Some(route)
    | None =>
      children
      ->Dict.valuesToArray
      ->Array.findMap(child =>
        switch findlangRoutes(child, lang) {
        | Some(route) => Some(route)
        | None => None
        }
      )
    }
  | None => None
  }
}

let writeArtePages = async outputPath => {
  langs
  ->Array.map(async lang => {
    try {
      let source = await getArtePageByLang(lang)
      let routes = fromArtePages(source, lang)
      switch findlangRoutes(routes, lang) {
      | Some(langRoutes) =>
        await NodeFs.writeFile(`${outputPath}/${lang}.json`, langRoutes->Js.Json.stringifyAny)
      | None => raise(ParseError("No routes found for language: " ++ lang))
      }
    } catch {
    | Exn.Error(err) => Console.log4("Error fetching arte page for language", lang, ":", err)
    | S.Error(err) => Console.log4("Error parsing arte page for language", lang, ":", err)
    }->ignore
  })
  ->Promise.all
}

writeArtePages("../../apps/arteflix/arteRoutes/")
->Promise.then(_ => {
  Js.log("Arte pages written successfully.")
  Promise.resolve()
})
->Promise.catch(err => {
  Js.log2("Error writing arte pages:", err)
  Promise.reject(err)
})
->ignore
