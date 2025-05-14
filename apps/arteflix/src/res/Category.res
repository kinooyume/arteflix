open ArteContract

let revalidate = 60

let dynamicParams = true

let default = async (promiseParams: promise<Params.category>) => {
  let params = await promiseParams
  <CategoryClient params />
}
