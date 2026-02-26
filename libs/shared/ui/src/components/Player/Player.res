open Emotion
let document = Webapi.Dom.document
module Document = Webapi.Dom.Document
module Element = Webapi.Dom.Element

%%raw("import 'video.js/dist/video-js.css'")

module Style = {
  let wrapper =
    ReactDOM.Style.make(~width="100%", ~height="100dvh", ~borderRadius=Radius.sm, ())->css

  let player = `
/* Kill all video.js opacity/visibility/transition on controls */
.vjs-control-bar,
.vjs-control-bar *,
.vjs-control-bar *:before,
.vjs-control-bar *:after {
  opacity: 1 !important;
  transition: none !important;
}

.vjs-control-bar {
  background-color: transparent !important;
  height: 92px !important;
  padding: 16px 20px !important;
  visibility: visible !important;
  display: flex !important;
}


/* Hidden state: class toggled by NetflixMode */
.netflix-controls-hidden .vjs-control-bar {
  display: none !important;
}
.netflix-controls-hidden .netflix-gradient {
  display: none !important;
}
.netflix-controls-hidden {
  cursor: none !important;
}

/* Button sizing */
.vjs-button {
  width: 34px;
  height: 42px;
  align-items: center;
  padding: 0 32px;
}
.vjs-button > .vjs-icon-placeholder:before {
  font-size: 2.3em;
}

/* Time display */
.vjs-time-control {
  position: absolute !important;
  right: 0 !important;
  top: -25px !important;
}

/* Volume */
.vjs-volume-panel {
  margin-right: auto !important;
}
.vjs-volume-control {
  padding-top: 6px !important;
}
.vjs-mute-control.vjs-vol-0 ~ .vjs-volume-control {
  display: none !important;
}

/* Menu */
.vjs-menu {
  width: 256px !important;
  border: none !important;
  bottom: -12px;
  left: -180px;
  border-radius: ${Radius.sm};
  border: 1px solid transparent;
}
${Responsive.mobileDown} {
  .vjs-menu {
    left: auto;
    right: 0;
    width: min(256px, 90vw) !important;
  }
  .vjs-button {
    padding: 0 12px;
  }
}
.vjs-menu .vjs-menu-content {
  background-color: ${Colors.greyGrey_750} !important;
  justify-content: flex-start !important;
  font-family: "Netflix Sans" !important;
}
.vjs-menu .vjs-menu-content .vjs-menu-item {
  display: flex !important;
  padding: 15px 20px !important;
  gap: 10px !important;
}
.vjs-menu li {
  justify-content: flex-start !important;
}
.vjs-menu .vjs-menu-content .vjs-menu-item span {
  text-align: left !important;
  color: var(--Grey-Grey-100, #B3B3B3) !important;
  font-family: "Netflix Sans" !important;
  font-size: 14px !important;
  font-style: normal !important;
  font-weight: 400 !important;
  line-height: 16px !important;
}
.vjs-menu-item.vjs-selected {
  background-color: ${Colors.greyGrey_750} !important;
  color: #FFF !important;
}
.vjs-menu .vjs-menu-content .vjs-menu-item.vjs-selected span {
  color: #FFF !important;
}
.vjs-menu .vjs-menu-content .vjs-menu-item:hover {
  background-color: ${Colors.greyGrey_750} !important;
}
.vjs-menu .vjs-menu-content .vjs-menu-item:hover span {
  color: #FFF !important;
}

/* Episodes menu — hidden for now */
.vjs-episodes-button {
  display: none !important;
}
.vjs-episodes-button .vjs-menu {
  max-height: 60vh;
}
.vjs-episodes-button .vjs-menu .vjs-menu-content {
  max-height: calc(60vh - 20px);
  overflow-y: auto;
}
.vjs-season-header {
  pointer-events: none !important;
  padding: 12px 20px 6px !important;
  font-weight: 700 !important;
  font-size: 13px !important;
  text-transform: uppercase !important;
  letter-spacing: 0.5px !important;
  color: rgba(255,255,255,.5) !important;
  border-top: 1px solid rgba(255,255,255,.1) !important;
}
.vjs-season-header:first-child {
  border-top: none !important;
}

/* Progress bar */
.vjs-progress-control {
  height: 6px !important;
  position: absolute !important;
  top: 0;
  left: 0;
  right: 0;
  width: calc(100% - 92px) !important;
}
.vjs-progress-control .vjs-progress-holder {
  height: 6px;
}
.vjs-mouse-display {
  width: 16px;
  height: 16px;
  flex-shrink: 0;
  border-radius: ${Radius.md};
  background-color: ${Colors.secondaryRed_300};
}
.vjs-time-tooltip {
  display: none !important;
}
.vjs-slider {
  background-color: ${Colors.greyGrey_200} !important;
}
.vjs-play-progress {
  background-color: ${Colors.secondaryRed_300} !important;
}
.vjs-play-progress:before {
  font-size: 1.2em;
  color: ${Colors.secondaryRed_300} !important;
}
.vjs-load-progress, .vjs-load-progress div {
  background-color: ${Colors.greyGrey_25} !important;
}

.vjs-progress-control,
.vjs-progress-holder {
  overflow: visible !important;
}

.vjs-sprite-thumbnail {
  position: absolute;
  bottom: 100%;
  margin-bottom: 8px;
  pointer-events: none;
  border-radius: 4px;
  box-shadow: 0 2px 8px rgba(0,0,0,.6);
  display: none;
  z-index: 2;
  overflow: hidden;
  background-color: #141414;
}
.vjs-sprite-thumbnail-img {
  display: block;
}
.vjs-sprite-thumbnail-time {
  font-family: Netflix Sans, Tahoma, Verdana, sans-serif;
  font-size: 12px;
  font-weight: 600;
  color: #fff;
  text-align: center;
  padding: 4px 0;
}

    `->rawCss
}

type videoProps = {
  url: string,
  options: VideoJs.playerOptions,
  onPlayer?: VideoJs.t => unit,
  title?: string,
  subtitle?: string,
  episodes?: array<NetflixMode.episodeGroup>,
  onEpisodeSelect?: NetflixMode.episode => unit,
}

@react.component(: videoProps)
let make = (~url, ~options, ~onPlayer=?, ~title=?, ~subtitle=?, ~episodes=?, ~onEpisodeSelect=?) => {
  let videoRef = React.useRef(Js.Nullable.null)
  let playerRef = React.useRef(Js.Nullable.null)
  let prevUrlRef = React.useRef(url)

  React.useEffect(() => {
    switch playerRef.current {
    | Value(video) => {
        switch options.autoplay {
        | Some(autoplay) => video->VideoJs.autoplay(~autoplay)
        | None => ()
        }
        let _ = video->VideoJs.src(url)
        None
      }
    | _ =>
      switch videoRef.current {
      | Value(ref) => {
          let videoElement = document->Document.createElement("video-js")
          let class =
            " video-js vjs-big-play-centered vjs-fill " ++
            Style.player ++
            " " ++
            Typo.Regular.headline2Force

          videoElement->Element.setClassName(class)

          ref->Element.appendChild(~child=videoElement)
          playerRef.current = Value(videoElement)
          let video = VideoJs.videojs(~id=#Element(videoElement), ~options)
          playerRef.current = Value(video)
          switch options.autoplay {
          | Some(autoplay) => video->VideoJs.autoplay(~autoplay)
          | None => ()
          }
          video->VideoJs.ready(~fn=() => {
            let _ = VideoJs.src(video, url)
            switch episodes {
            | Some(eps) if eps->Array.length > 0 =>
              NetflixMode.updateEpisodeMenu(video, eps)
              switch title {
              | Some(t) => NetflixMode.updateTitle(video, ~title=t, ~subtitle?)
              | None => ()
              }
              switch onEpisodeSelect {
              | Some(cb) => NetflixMode.setOnEpisodeSelect(video, cb)
              | None => ()
              }
            | _ => ()
            }
          }, ~sync=true)
          NetflixMode.setup(video, ~title?)
          ThumbnailSprites.setup(video, url)
          switch onPlayer {
          | Some(cb) => cb(video)
          | None => ()
          }
          None
        }
      | _ => None
      }
    }
  }, [videoRef])

  React.useEffect1(() => {
    let prevUrl = prevUrlRef.current
    if prevUrl != url {
      prevUrlRef.current = url
      switch playerRef.current {
      | Value(video) =>
        let _ = video->VideoJs.src(url)
        video->VideoJs.play
      | _ => ()
      }
    }
    None
  }, [url])

  React.useEffect2(() => {
    switch (playerRef.current, episodes) {
    | (Value(video), Some(eps)) if eps->Array.length > 0 =>
      NetflixMode.updateEpisodeMenu(video, eps)
      switch title {
      | Some(t) => NetflixMode.updateTitle(video, ~title=t, ~subtitle?)
      | None => ()
      }
      switch onEpisodeSelect {
      | Some(cb) => NetflixMode.setOnEpisodeSelect(video, cb)
      | None => ()
      }
    | (Value(video), _) =>
      switch onEpisodeSelect {
      | Some(cb) => NetflixMode.setOnEpisodeSelect(video, cb)
      | None => ()
      }
    | _ => ()
    }
    None
  }, (episodes, onEpisodeSelect))

  React.useEffect(() => {
    Some(
      () => {
        switch playerRef.current {
        | Value(video) =>
          if !(video->VideoJs.isDisposed) {
            let _ = video->VideoJs.dispose()
            let _ = playerRef.current = Js.Nullable.null
          }
        | _ => ()
        }
      },
    )
  }, [playerRef])

  <div className={Style.wrapper}>
    <div
      className={" video-js vjs-fill " ++ Style.player ++ " " ++ Typo.Regular.headline2Force}
      ref={ReactDOM.Ref.domRef(videoRef)}
    />
  </div>
}
