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
      let path = switch title {
      | None => `/${lang}/${category}`
      | Some(t) => `/${lang}/${category}/${t}`
      }
      await get(~path)
    },
  }
}

let source = make("https://www.arte.tv")
