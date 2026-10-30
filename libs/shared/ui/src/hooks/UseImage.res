type status = Loading | Loaded | Failed

let retryDelay = 60000

let isErrorPlaceholder = naturalWidth => naturalWidth > 0 && naturalWidth < 100

let useImage = (src: string) => {
  let (status, setStatus) = React.useState(() => Loading)
  let (retried, setRetried) = React.useState(() => false)

  React.useEffect(() => {
    setStatus(_ => Loading)
    setRetried(_ => false)
    None
  }, [src])

  React.useEffect(() => {
    switch (status, retried) {
    | (Failed, false) =>
      let timer = setTimeout(() => {
        setRetried(_ => true)
        setStatus(_ => Loading)
      }, retryDelay)
      Some(() => clearTimeout(timer))
    | _ => None
    }
  }, (status, retried))

  let onLoad = React.useCallback0(naturalWidth =>
    setStatus(_ => isErrorPlaceholder(naturalWidth) ? Failed : Loaded)
  )
  let onError = React.useCallback0(() => setStatus(_ => Failed))

  (status, onLoad, onError)
}
