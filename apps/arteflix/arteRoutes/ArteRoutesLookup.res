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
