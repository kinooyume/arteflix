let locales = ["en", "fr", "de", "es", "it", "pl"]

let getLocale = (headers: Next.Server.Header.t) => {
  let locale = switch headers.get("accept-language") {
  | Value(lang) => lang->String.slice(~start=0, ~end=2)
  | _ => "en"
  }

  switch locales->Array.includes(locale) {
  | true => locale->String.toLowerCase
  | false => "en"
  }
}

let default = (headers) => {
  let locale = getLocale(headers)
  Next.Navigation.redirect("/" ++ locale)
}

