let locales = ["en", "fr", "de", "es", "it", "pl"]

let getLocale = (headers : Next.Server.Header.t) => {
  let locale = switch headers.get("accept-language") {
| Value(lang) => lang->String.slice(~start=0, ~end=2)
| _ => "en"
  }

  switch locales->Array.includes(locale) {
  | true => locale->String.toLowerCase
  | false => "en"
  }
}

let middleware: Next.Middleware.middleware = req => {

  let locale = getLocale(req.headers)
  Next.Server.nextResponse.redirect(WebApiURL.make(req.nextUrl.origin ++ "/" ++ locale))
}

let config: Next.Middleware.config = {
  matcher: "/",
}

