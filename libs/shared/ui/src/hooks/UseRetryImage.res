let useRetryImage = (~src, ~maxRetries=3) => {
  let (retryCount, setRetryCount) = React.useState(() => 0)

  let currentSrc = switch retryCount {
  | 0 => src
  | n =>
    let sep = src->String.includes("?") ? "&" : "?"
    src ++ sep ++ "_r=" ++ n->Int.toString
  }

  let onError = _ => {
    if retryCount < maxRetries {
      setTimeout(() => setRetryCount(prev => prev + 1), 1000)->ignore
    }
  }

  (currentSrc, onError)
}
