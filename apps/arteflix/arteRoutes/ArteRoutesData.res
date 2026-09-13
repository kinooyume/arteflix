@module external de: ArteRoutes.t = "./de.json"
@module external en: ArteRoutes.t = "./en.json"
@module external es: ArteRoutes.t = "./es.json"
@module external fr: ArteRoutes.t = "./fr.json"
@module external it: ArteRoutes.t = "./it.json"
@module external pl: ArteRoutes.t = "./pl.json"

let routes = Dict.fromArray([
  ("de", de),
  ("en", en),
  ("es", es),
  ("fr", fr),
  ("it", it),
  ("pl", pl),
])

let findPage = ArteRoutesLookup.findPage
