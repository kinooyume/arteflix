// Bon alors ici
// C'est la partie, on récupère le html
// On parse, valide et tout ça
// et on Renvoit une promesse de ArteData.t

open Fetch

exception FetchError(Exn.t)
exception ArteStatusError(int)
exception HtmlParsingError(string)

let make = (baseUrl): ArteParser.Endpoints.t => {
  let fetch = async urlParams => {
    try {
      let resp = await fetch(
        baseUrl ++ urlParams,
        {
          method: #GET,
        },
      )

      switch Response.ok(resp) {
      | true => await Response.text(resp)
      | false => raise(ArteStatusError(resp->Response.status))
      }
    } catch {
    | Exn.Error(err) => raise(FetchError(err))
    }
  }

  let parse = html => {
    switch HTMLParser.parse(html) {
    | Value(arteHtml) =>
      switch HTMLParser.Element.querySelector(arteHtml, "#__NEXT_DATA__") {
      | Value(nextData) =>
        switch nextData.childNodes->Array.get(0) {
        | Some(node) => node.rawText
        | None => raise(HtmlParsingError("NEXT_DATA is empty"))
        }
      | _ => raise(HtmlParsingError("NEXT_DATA is missing"))
      }
    | _ => raise(HtmlParsingError("invalid HTML"))
    }
  }

  // NOTE: utilisé en front
  // let validate = text =>
  //   switch text->S.parseOrThrow(ArteDataHtml.schema) {
  //   | Ok(data) => data
  //   | Error(err) => raise(ParseError(err))
  //   }
  //
  // let validate = text =>
  // let validate = text => {
  //   Js.log("Validate time !")
  //   try "t"->S.parseJsonStringOrThrow(ArteDataHtml.schema) catch {
  //   | S.Raised(err) => {
  //       Js.log(err)
  //       raise(ParseError(err))
  //     }
  //   }
  // }

  let transform = (data: ArteDataHtml.t): ArteData.t => {
    let {page, parent, metadata, apiPlayerConfig} = data.props.pageProps.props
    {
      content: {
        zones: page.value.zones,
        parent,
        metadata,
      },
      apiPlayerConfig,

      // ->ArteData.toJson
      // ->JSONUtils.stripUndefined
      // ->ArteData.fromJson
    }
  }

  let get = async (~path) => {
    let html = await fetch(path)
    html
    ->parse
    ->S.parseJsonStringOrThrow(ArteDataHtml.schema)
    ->transform
  }

  {
    home: async ({lang}) => {
      await get(~path=`/${lang}`)
    },
    direct: async ({lang}) => {
      let path = `/${lang}/direct`
      await get(~path)
    },
    video: async ({lang, id}) => {
      // Faut voir l'entourloupe des categories
      let path = `/${lang}/videos/${id}`
      await get(~path)
    },
    category: async ({lang, category, title}) => {
      // let categoryPath = switch title {
      //   | Some(title) => title
      //   | None => "categories"
      // }
      let path = switch title {
      | None => `/${lang}/${category}`
      | Some(t) => `/${lang}/${category}/${t}`
      }
      await get(~path)
    },
  }

  // let path = queries->Js.Dict.values->Array.join("/")
  // let urlParams = params->Js.Dict.values->Array.join("/")
}

let source = make("https://www.arte.tv")
