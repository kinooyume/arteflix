// @@directive("'use server';")
open ArteParser.Endpoints

let default = async (promiseParams: promise<Params.direct>) => {
  let params = await promiseParams
  <LiveClient params />
}
