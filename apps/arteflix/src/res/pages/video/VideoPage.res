// @@directive("'use server';")
open ArteContract

module VideoClientMemo = {
  let make = React.memo(VideoPageClient.make)
}

let default = async (promiseParams: promise<Params.program>) => {
  let params = await promiseParams
  <VideoClientMemo params />
}
