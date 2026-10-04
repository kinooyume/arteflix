type status = Pending | Ready(string) | Failed

let useAsset = (~url: string, ~priority: AssetQueue.priority=Low) => {
  let (status, setStatus) = React.useState(() =>
    switch AssetQueue.getCached(url) {
    | Some(AssetQueue.Loaded) => Ready(url)
    | Some(AssetQueue.Failed(n)) if n >= 3 => Failed
    | _ => Pending
    }
  )

  React.useEffect(() => {
    switch status {
    | Ready(_) => None
    | Failed => None
    | Pending =>
      let cleanup = AssetQueue.request(
        ~url,
        ~priority,
        ~onReady=() => setStatus(_ => Ready(url)),
      )
      Some(cleanup)
    }
  }, (url, status))

  React.useEffect(() => {
    switch AssetQueue.getCached(url) {
    | Some(AssetQueue.Failed(n)) if n >= 3 => setStatus(_ => Failed)
    | _ => ()
    }
    None
  }, (url, status))

  let retryTimer = React.useRef(None)

  React.useEffect(() => {
    Some(() => {
      switch retryTimer.current {
      | Some(t) => clearTimeout(t)
      | None => ()
      }
    })
  }, [url])

  let onLoad = React.useCallback((naturalWidth: int) => {
    if naturalWidth > 0 && naturalWidth < 100 {
      AssetQueue.fail(~url=url)
      let retries = switch AssetQueue.getCached(url) {
      | Some(AssetQueue.Failed(n)) => n
      | _ => 1
      }
      switch retryTimer.current {
      | Some(t) => clearTimeout(t)
      | None => ()
      }
      if retries < 3 {
        let delay = 2000 * Int.fromFloat(Math.pow(2.0, ~exp=(retries - 1)->Int.toFloat))
        retryTimer.current = Some(
          setTimeout(() => {
            retryTimer.current = None
            setStatus(_ => Pending)
          }, delay),
        )
      } else {
        setStatus(_ => Pending)
      }
    } else {
      AssetQueue.complete(~url=url)
    }
  }, [url])
  let onError = React.useCallback(() => {
    AssetQueue.fail(~url=url)
    let retries = switch AssetQueue.getCached(url) {
    | Some(AssetQueue.Failed(n)) => n
    | _ => 1
    }
    switch retryTimer.current {
    | Some(t) => clearTimeout(t)
    | None => ()
    }
    if retries < 3 {
      let delay = 2000 * Int.fromFloat(Math.pow(2.0, ~exp=(retries - 1)->Int.toFloat))
      retryTimer.current = Some(
        setTimeout(() => {
          retryTimer.current = None
          setStatus(_ => Pending)
        }, delay),
      )
    } else {
      setStatus(_ => Pending)
    }
  }, [url])

  (status, onLoad, onError)
}
