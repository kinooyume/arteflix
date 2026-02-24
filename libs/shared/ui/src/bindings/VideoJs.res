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

type netflixModeOptions = {inactivityTimeout?: int}

@send external netflixMode: (t, ~options: netflixModeOptions=?) => unit = "netflixMode"
