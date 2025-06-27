@schema
type page = {
  code: string,
  label: string,
  description: option<string>,
  alternativeLanguages: option<array<ArtePages.alternativeLanguage>>,
}

type rec route = {
  page?: page,
  children?: dict<route>,
}

let routeSchema = S.recursive(routeSchema => {
  S.object(s => {
    page: s.field("page", pageSchema),
    children: s.field("children", S.dict(routeSchema)),
  })
})

@schema
type t = route

let rec appendFromList = (t: t, slugs: list<string>, page: page): t => {
  let children = switch t.children {
  | Some(children) => children
  | None => Dict.make()
  }
  switch slugs {
  | list{} => {...t, page}
  | list{slug, ...rest} => {
      let innerT = switch children->Dict.get(slug) {
      | Some(inner) => inner
      | None => ({}: t)
      }
      let newInnerT = appendFromList(innerT, rest, page)
      children->Dict.set(slug, newInnerT)
      {...t, children}
    }
  }
}

let fromArtePages = (pages: ArtePages.t, lang: string) => {
  pages.value->Array.reduce(({}: t), (acc, entry) => {
    let page = {
      code: entry.code,
      label: entry.label,
      description: entry.description,
      alternativeLanguages: entry.alternativeLanguages,
    }
    // NOTE: the href field is not always up to date
    // We use the alternativeLanguage o the current lang
    let href = switch entry.alternativeLanguages {
    | Some(altLangs) => switch altLangs->Array.find(alt => alt.code == lang) {
      | Some(page) => page.url
      | None => entry.href
      }
    | None => entry.href
    }
    let slugs = href->String.split("/")->List.fromArray
    appendFromList(acc, slugs, page)
    // })
  })
}
