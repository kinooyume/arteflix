// @@directive("'use server';")
open ArteContract

module VideoClientMemo = {
  let make = React.memo(VideoClient.make)
}

let default = async (promiseParams: promise<Params.video>) => {
  let params = await promiseParams
  <VideoClientMemo params />
}
