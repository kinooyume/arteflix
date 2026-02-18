@@directive("'use client';")

let navCodes = ["CATEGORY_CIN", "CATEGORY_SER", "ARTE_CONCERT"]

let categoriesLabel =
  [
    ("de", "Kategorien"),
    ("en", "Categories"),
    ("es", `Categorías`),
    ("pl", "Kategorie"),
    ("it", "Categorie"),
  ]->Dict.fromArray

let langOptions: array<HeaderLangSelector.lang> = [
  {code: "fr", label: `Français`, href: "/fr/"},
  {code: "de", label: "Deutsch", href: "/de/"},
  {code: "en", label: "English", href: "/en/"},
  {code: "es", label: `Español`, href: "/es/"},
  {code: "pl", label: "Polski", href: "/pl/"},
  {code: "it", label: "Italiano", href: "/it/"},
]

@react.component
let make = () => {
  let params = Next.Navigation.useParams()
  let lang = params->Dict.get("lang")->Option.getOr("fr")

  let allCategories =
    CategoryData.data
    ->Dict.get(lang)
    ->Option.getOr([])

  let links =
    allCategories
    ->Array.filter(c => navCodes->Array.includes(c.code))
    ->Array.map(c => {HeaderNav.text: c.text, href: c.href})

  let categories =
    allCategories->Array.map(c => {HeaderNav.text: c.text, href: c.href})

  let label = categoriesLabel->Dict.get(lang)->Option.getOr(`Catégories`)

  <Header
    logo={{homeHref: `/${lang}`, src: "/static/logo.png", alt: "Arteflix"}}
    links
    categories
    categoriesLabel=label
    right={<HeaderLangSelector current=lang langs=langOptions />}
  />
}
