open ArteContract

let revalidate = 60
let dynamicParams = true

let default = async (promiseParams: promise<Params.categoryPage>) => {
  let params = await promiseParams

  let slug =
    params.slug
    ->Array.map(s => s->String.split(","))
    ->Array.flat
    ->Array.join("/")

  let p: Params.category = {
    lang: params.lang,
    slug,
  }

  // const slug = params.slug
  //   .map((s) => s.split(','))
  //   .flat()
  //   .join('/');
  <CategoryPageClient params={p} />
}
