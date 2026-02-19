open Emotion

module Style = {
  let container = ReactDOM.Style.make(~width="100%", ~height="100%", ())->css

  let children =
    ReactDOM.Style.make(~position="absolute", ~top="0", ~left="0", ~right="0", ~bottom="0", ())->css
}

type url = Some(string) | ToFetch(unit => Js.Promise.t<string>) | NoVideo

type props_ = {
  urlOption: url,
  children: React.element,
}

@react.component(: props_)
let make = (~urlOption, ~children) => {
  let (isLoaded, setIsLoaded) = React.useState(_ => false)
  let (url, setUrl) = React.useState(_ => None)

  let _ = switch urlOption {
  | NoVideo => ()
  | Some(videoUrl) => setUrl(_ => Some(videoUrl))
  | ToFetch(fetch) => React.useEffect(() => {
      let _ = fetch()->Promise.then(videoUrl => Promise.resolve(setUrl(_ => Some(videoUrl))))
      None
    }, [urlOption])
  }

  open FramerMotion
  <div className={Style.container}>
    <MoviePreviewPresence isVisible={!isLoaded}>
      <Motion.div key="children" exit={{opacity: 0.0, transition: {duration: 0.1}}}>
        <div className={Style.children}> children </div>
      </Motion.div>
      <MoviePreviewPresence.Container />
    </MoviePreviewPresence>
    {switch url {
    | Some(videoUrl) =>
      <PlayerMinimal
        url={videoUrl}
        options={{
          autoplay: #play,
          preload: #auto,
          fluid: false,
        }}
        onLoaded={_ => setIsLoaded(_ => true)}
      />
    | None => React.null
    }}
  </div>
}
