open Emotion

module Style = {
  let container = visible =>
    `
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    z-index: 2;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding-left: 4%;
    padding-right: 40%;
    pointer-events: none;
    background: linear-gradient(to right, rgba(0,0,0,.7) 0%, rgba(0,0,0,.4) 40%, transparent 70%);
    opacity: ${visible ? "1" : "0"};
    transition: opacity .3s;
    text-shadow: 2px 2px 4px rgba(0,0,0,.45);
  `->rawCss

  let title =
    `
    margin: 0 0 6px;
    font-family: Netflix Sans, Tahoma, Verdana, sans-serif;
    font-size: clamp(18px, 0.9rem + 0.75vw, 28px);
    font-weight: 700;
    line-height: 1.2;
    color: #fff;
  `->rawCss

  let subtitle =
    `
    display: block;
    font-family: Netflix Sans, Tahoma, Verdana, sans-serif;
    font-size: clamp(13px, 0.65rem + 0.35vw, 17px);
    font-weight: 400;
    line-height: 1.4;
    color: rgba(255,255,255,.8);
  `->rawCss
}

type overlayProps = {
  player: Js.Nullable.t<VideoJs.t>,
  title: string,
  subtitle?: string,
}

@react.component(: overlayProps)
let make = (~player, ~title, ~subtitle=?) => {
  let (visible, setVisible) = React.useState(() => false)
  let timerRef = React.useRef(None)

  let clearTimer = () =>
    switch timerRef.current {
    | Some(id) =>
      Js.Global.clearTimeout(id)
      timerRef.current = None
    | None => ()
    }

  React.useEffect(() => {
    switch player {
    | Value(p) => {
        let onPause = () => {
          clearTimer()
          timerRef.current = Some(
            Js.Global.setTimeout(() => setVisible(_ => true), 5000),
          )
        }
        let onPlay = () => {
          clearTimer()
          setVisible(_ => false)
        }

        p->VideoJs.on(~event="pause", ~fn=onPause)
        p->VideoJs.on(~event="play", ~fn=onPlay)

        Some(
          () => {
            clearTimer()
            p->VideoJs.off(~event="pause", ~fn=onPause)
            p->VideoJs.off(~event="play", ~fn=onPlay)
          },
        )
      }
    | _ => None
    }
  }, [player])

  <div className={Style.container(visible)}>
    <h4 className={Style.title}> {title->React.string} </h4>
    {switch subtitle {
    | Some(sub) => <span className={Style.subtitle}> {sub->React.string} </span>
    | None => React.null
    }}
  </div>
}
