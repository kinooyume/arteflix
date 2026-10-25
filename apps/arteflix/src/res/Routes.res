open ArteContract

let locales = ["en", "fr", "de", "es", "it", "pl"]

type t =
  | Root
  | Home(Params.home)
  | Live(Params.live)
  | LivePage(Params.live)
  | Video(Params.program)
  | Category(Params.category)

@val external decodeURIComponent: string => string = "decodeURIComponent"

let parse = pathname =>
  switch pathname
  ->String.split("/")
  ->Array.filter(s => s != "")
  ->Array.map(decodeURIComponent) {
  | [] => Root
  | [lang] => Home({lang: lang})
  | ["fr", "direct"] => Live({lang: "fr"})
  | ["de", "live"] => Live({lang: "de"})
  | [lang, "direct"] => LivePage({lang: lang})
  | [lang, "videos", id] => Video({lang, id})
  | [lang, "videos", id, title] => Video({lang, id, title})
  | segments =>
    Category({
      lang: segments->Array.getUnsafe(0),
      slug: segments->Array.sliceToEnd(~start=1)->Array.join("/"),
    })
  }

let localeOf = language => {
  let locale = language->String.slice(~start=0, ~end=2)->String.toLowerCase
  locales->Array.includes(locale) ? locale : "en"
}
