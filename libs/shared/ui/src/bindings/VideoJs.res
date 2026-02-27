type t = Dom.element

type controlBar = {
  children: array<string>
}

type preload = [#auto | #metadata | #none]
type autoplay  = [ #play | #muted | #any ]


@live
type playerOptions = {
  autoplay?: autoplay,
  controls?: bool,
  fluid?: bool,
  loop?: bool,
  preload?: preload,
  controlBar?: controlBar
}

@module("video.js")
external videojs: (
  ~id: @unwrap
  [
    | #String(string)
    | #Element(Dom.element)
  ],
  ~options: playerOptions,
  ~ready: unit => 'a=?,
) => t = "default"

@send @return(nullable) external src: (t, string) => option<string> = "src"
@send external dispose: (t, unit) => unit = "dispose"
@send external isDisposed: (t) => bool = "isDisposed"
@send external ready: (t, ~fn: unit => 'a, ~sync: bool=?) => unit = "ready"
@send external autoplay: (t, ~autoplay: autoplay) => unit = "autoplay"
@send external on: (t, ~event: string, ~fn: unit => unit) => unit = "on"

@send external el: t => Dom.element = "el"
@send external paused: t => bool = "paused"
@send external off: (t, ~event: string, ~fn: unit => unit) => unit = "off"

type component
@send @return(nullable) external getChild: (t, string) => option<component> = "getChild"
@send external hideComponent: component => unit = "hide"

@send external play: t => unit = "play"
@send external pause: t => unit = "pause"
@send external muted: t => bool = "muted"
@send external setMuted: (t, bool) => unit = "muted"
@send external isFullscreen: t => bool = "isFullscreen"
@send external requestFullscreen: t => unit = "requestFullscreen"
@send external exitFullscreen: t => unit = "exitFullscreen"
@send external currentTime: t => float = "currentTime"
@send external setCurrentTime: (t, float) => unit = "currentTime"
@send external duration: t => float = "duration"
@send external volume: t => float = "volume"
@send external setVolume: (t, float) => unit = "volume"

@send @return(nullable)
external querySelector: (Dom.element, string) => option<Dom.element> = "querySelector"
