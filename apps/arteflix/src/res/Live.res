// @@directive("'use server';")
open ArteContract

let default = async (promiseParams: promise<Params.direct>) => {
  let params = await promiseParams
  <LiveClient params />
}
