// @@directive("'use server';")
open ArteContract

let default = async (promiseParams: promise<Params.live>) => {
  let params = await promiseParams
  <LiveClient params />
}
