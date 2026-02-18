let revalidate = 60
let dynamicParams = true

let default = async (promiseParams: promise<ArteContract.Params.live>) => {
  let params = await promiseParams
  <LivePageClient params />
}
