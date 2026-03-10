type status = Pending | Ready(string) | Failed

let ensureTypeText = url =>
  switch url->String.includes("type=TEXT") {
  | true => url
  | false =>
    let sep = url->String.includes("?") ? "&" : "?"
    url ++ sep ++ "type=TEXT"
  }

let stripTypeText = url =>
  url
  ->String.replaceAll("&type=TEXT", "")
  ->String.replaceAll("?type=TEXT&", "?")
  ->String.replaceAll("?type=TEXT", "")

type phase = WithText | WithoutText

let useAsset = (~url: string, ~priority: AssetQueue.priority=Low, ~ensureText: bool=true) => {
  let urlWithText = ensureText ? ensureTypeText(url) : url
  let urlWithoutText = ensureText ? stripTypeText(url) : url
  let initialUrl = ensureText ? urlWithText : url

  let (phase, setPhase) = React.useState((): phase => WithText)
  let currentUrl = switch (ensureText, phase) {
  | (true, WithText) => urlWithText
  | (true, WithoutText) => urlWithoutText
  | (false, _) => url
  }

  let (status, setStatus) = React.useState(() =>
    switch AssetQueue.getCached(currentUrl) {
    | Some(AssetQueue.Loaded) => Ready(currentUrl)
    | Some(AssetQueue.Failed(n)) if n >= 3 =>
      switch (ensureText, phase) {
      | (true, WithText) => Pending
      | _ => Failed
      }
    | _ => Pending
    }
  )

  React.useEffect(() => {
    switch status {
    | Ready(_) => None
    | Failed => None
    | Pending =>
      let cleanup = AssetQueue.request(
        ~url=currentUrl,
        ~priority,
        ~onReady=() => setStatus(_ => Ready(currentUrl)),
      )
      Some(cleanup)
    }
  }, (currentUrl, status))

  React.useEffect(() => {
    switch (ensureText, phase, AssetQueue.getCached(currentUrl)) {
    | (true, WithText, Some(AssetQueue.Failed(n))) if n >= 3 =>
      setPhase(_ => WithoutText)
      setStatus(_ => Pending)
    | (_, _, Some(AssetQueue.Failed(n))) if n >= 3 =>
      setStatus(_ => Failed)
    | _ => ()
    }
    None
  }, (currentUrl, status))

  let retryTimer = React.useRef(None)

  React.useEffect(() => {
    Some(() => {
      switch retryTimer.current {
      | Some(t) => clearTimeout(t)
      | None => ()
      }
    })
  }, [currentUrl])

  let onLoad = React.useCallback(() => AssetQueue.complete(~url=currentUrl), [currentUrl])
  let onError = React.useCallback(() => {
    AssetQueue.fail(~url=currentUrl)
    let retries = switch AssetQueue.getCached(currentUrl) {
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
  }, [currentUrl])

  (status, onLoad, onError)
}
