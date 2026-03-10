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
    | _ => ()
    }
    None
  }, (currentUrl, status))

  let onLoad = React.useCallback(() => AssetQueue.complete(~url=currentUrl), [currentUrl])
  let onError = React.useCallback((is429: bool) => {
    AssetQueue.fail(~url=currentUrl, ~is429)
    setStatus(_ => Pending)
  }, [currentUrl])

  (status, onLoad, onError)
}
