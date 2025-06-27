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

let rec findPage = (routes: ArteRoutes.t, slugs: list<string>): option<ArteRoutes.page> => {
  switch slugs {
  | list{} =>
    switch routes.page {
    | Some(page) => Some(page)
    | None =>
      switch routes.children {
      | Some(children) =>
        switch children->Dict.get("") {
        | Some(innerRoutes) =>
          switch innerRoutes.page {
          | Some(page) => Some(page)
          | None => None
          }
        | None => None
        }
      | None => None
      }
    }
  | list{slug, ...rest} => {
      switch routes.children {
      | Some(children) =>
        switch children->Dict.get(slug) {
        | Some(innerRoutes) => findPage(innerRoutes, rest)
        | None => None
        }
      | None => None
      }
    }
  }
}
