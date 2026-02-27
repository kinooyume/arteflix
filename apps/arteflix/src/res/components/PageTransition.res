@@directive("'use client';")
open Emotion

let base = `
  opacity: 1;
  transform: scale(1);
`->rawCss

let leavingZoomOut = `
  opacity: 0;
  transform: scale(1.03);
  transition: opacity 200ms ease-out, transform 200ms ease-out;
`->rawCss

let leavingZoomIn = `
  opacity: 0;
  transform: scale(0.97);
  transition: opacity 200ms ease-out, transform 200ms ease-out;
`->rawCss

let hidePopovers = `[role="dialog"] { opacity: 0 !important; transition: opacity 200ms ease-out !important; }`

@react.component
let make = (~children) => {
  let {isLeaving, zoomIn} = RouterProvider.useTransition()
  let leavingClass = zoomIn ? leavingZoomIn : leavingZoomOut
  <div className={isLeaving ? [base, leavingClass]->cx : base}>
    {isLeaving ? <style> {React.string(hidePopovers)} </style> : React.null}
    children
  </div>
}
