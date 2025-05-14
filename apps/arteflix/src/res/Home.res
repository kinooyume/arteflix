open ArteContract

let revalidate = 60

let dynamicParams = true

let default = async (promiseParams: promise<Params.home>) => {
  let params = await promiseParams
  <HomeClient params />
}
