open ArteContract

exception CategoryNotFound(string)

let key = ({lang, slug}: Params.category) => `category/${lang}/${slug}`

let fetch = async ({lang, slug}: Params.category) => {
  let routes = await ArteRoutesLoader.load(lang)
  switch routes->ArteRoutesLookup.findPage(slug->String.split("/")->List.fromArray) {
  | Some(page) =>
    await ClientFetcher.fetcher(ClientFetcher.validateArteData, ArteApiProxy.Urls.page(lang, page.code))
  | None => raise(CategoryNotFound(slug))
  }
}
